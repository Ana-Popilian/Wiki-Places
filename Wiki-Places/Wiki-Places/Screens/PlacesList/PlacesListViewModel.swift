//
//  PlacesListViewModel.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 20/06/2026.
//

import Combine
import SwiftUI


@MainActor
@Observable
final class PlacesListViewModel: BaseFactory {
  var isLoading: Bool = false
  var dataSource: [Model.Place] = []
  var isNetworkErrorPresented: Bool = false
  var searchText: String = ""
  var isSearchPresented = true
  var errorMessage: String = ""

  func fetchInitialLocationList() async {
    isLoading = true
    let result = await factory.placesService.fetchPlaces()
    handlePlacesFetchResult(result)
  }

  func searchNewPlaces() async {
    if !searchText.isEmpty {
      let result = await factory.placesService.searchAndFetchPlacesBy(searchText)
      handlePlacesFetchResult(result)
    }
  }
}

// MARK: - Private
private extension PlacesListViewModel {
  func handlePlacesFetchResult(_ result: Result<[Model.Place], PlaceError>) {
    isLoading = false
    switch result {
    case .success(let models):
      dataSource = models

    case .failure(let error):
      errorMessage = error.message
      isNetworkErrorPresented = true
    }
  }
}


//MARK: - Place Error type
enum PlaceError: Error {
  case poorInternetConnection
  case generic
}

// MARK: - Place Error message
extension PlaceError {

  //TODO, this can be localised
  var message: String {
    switch self {
    case .poorInternetConnection:
      "Poor internet connection, please check your internet speed and try again"

    case .generic:
      "Ops something went wrong, please try again"
    }
  }
}
