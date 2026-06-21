//
//  PlaceScreenViewModel.swift
//  Wiki-PlacesTests
//
//  Created by Ana Popilian on 20/06/2026.
//

import Testing
@testable import Wiki_Places

@MainActor
struct PlacesListViewModelTests {
  private let sut: PlacesListViewModel
  private let spy = FactorySpy()
  
  init() {
    sut = PlacesListViewModel(factory: spy)
  }
  
  @Test
  func whenFetchInitialLocationList_thenSuccess() async throws {
    //given
    let placeModel = Mock.place
    spy.placesServiceSpy.fetchPlacesResult = .success([placeModel])
    
    //when
    await sut.fetchInitialLocationList()
    
    //then
    let firstModel = try #require(sut.dataSource.first)
    #expect(firstModel == placeModel)
  }
  
  
  @Test
  func whenSearchNewPlaces_thenSuccess() async throws {
    let placeModel = Mock.place
    spy.placesServiceSpy.searchAndFetchPlacesByResult = .success([placeModel])
    sut.searchText = "Amsterdam"

    await sut.searchNewPlaces()

    #expect(spy.placesServiceSpy.passedSearchTerm == "Amsterdam")
    let firstModel = try #require(sut.dataSource.first)
    #expect(firstModel == placeModel)
  }
}
