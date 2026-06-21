//
//  PlacesWebServiceSpy.swift
//  Wiki-PlacesTests
//
//  Created by Ana Popilian on 21/06/2026.
//

import Foundation
@testable import Wiki_Places

final class PlacesWebServiceSpy: @unchecked Sendable {
  var fetchPlacesResult: Result<Dto.LocationResponse, NetworkError>!
  
  var passedSearchTerm: String!
  var searchAndFetchPlacesByResult: Result<Dto.WikipediaSearchResponse, NetworkError>!
}

//MARK: - PlacesWebServiceInterface
extension PlacesWebServiceSpy: PlacesWebServiceInterface {
  
  func fetchPlaces() async -> Result<Dto.LocationResponse, NetworkError> {
    return fetchPlacesResult
  }
  
  func searchAndFetchPlacesBy(_ searchTerm: String) async -> Result<Dto.WikipediaSearchResponse, NetworkError> {
    passedSearchTerm = searchTerm
    return searchAndFetchPlacesByResult
  }
}
