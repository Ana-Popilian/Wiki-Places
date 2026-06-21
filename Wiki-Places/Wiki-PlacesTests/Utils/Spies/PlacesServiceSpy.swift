//
//  PlacesServiceSpy.swift
//  Wiki-PlacesTests
//
//  Created by Ana Popilian on 20/06/2026.
//

import Foundation
@testable import Wiki_Places

final class PlacesServiceSpy: @unchecked Sendable {
  var fetchPlacesResult: Result<[Model.Place], PlaceError>!
  
  var passedSearchTerm: String!
  var searchAndFetchPlacesByResult: Result<[Model.Place], PlaceError>!
}

//MARK: - PlacesServiceInterface
extension PlacesServiceSpy: PlacesServiceInterface {
  
  func fetchPlaces() async -> Result<[Model.Place], PlaceError> {
    fetchPlacesResult
  }
  
  func searchAndFetchPlacesBy(_ searchTerm: String) async -> Result<[Model.Place], PlaceError> {
    passedSearchTerm = searchTerm
    return searchAndFetchPlacesByResult
  }
}
