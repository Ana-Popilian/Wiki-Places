//
//  PlacesService.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 20/06/2026.
//

import Foundation
import OSLog

protocol PlacesServiceInterface: Factorable {
  @concurrent func fetchPlaces() async -> Result<[Model.Place], PlaceError>
  @concurrent func searchAndFetchPlacesBy(_ searchTerm: String) async -> Result<[Model.Place], PlaceError>
}

struct PlacesService {
  var factory: ServiceFactorable
}

// MARK: - PlacesServiceInterface
extension PlacesService: PlacesServiceInterface {
  @concurrent func fetchPlaces() async -> Result<[Model.Place], PlaceError> {
    let result = await factory.placesWebService.fetchPlaces()
    
    switch result {
    case let .success(dtoList):
      let models = dtoList.locations.compactMap(\.model)
      
      //do other business logic with the fetched data
      
      return .success(models)
      
    case let .failure(error):
      return .failure(handleNetworkError(error))
    }
  }
  
  @concurrent func searchAndFetchPlacesBy(_ searchTerm: String) async -> Result<[Model.Place], PlaceError> {
    let result = await factory.placesWebService.searchAndFetchPlacesBy(searchTerm)
    
    switch result {
    case .success(let dto):
      guard let query = dto.query else {
        return .success([])
      }
      
      //do other business logic with the fetched data
      
      let models = query.pages.values.compactMap(\.model)
      return .success(models)
      
    case .failure(let error):
      return .failure(handleNetworkError(error))
    }
  }
}


// MARK: - Private
private extension PlacesService {
  //TODO: error handling, or propagate specific errors to viewModel to be handled differently, or only certain type of networking errors
  func handleNetworkError(_ error: NetworkError) -> PlaceError {
    guard error == .timeout else {
      return .generic
    }
    
    return .poorInternetConnection
  }
}
