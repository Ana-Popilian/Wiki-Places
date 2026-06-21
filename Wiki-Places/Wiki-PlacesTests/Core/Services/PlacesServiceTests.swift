//
//  PlacesServiceTests.swift
//  Wiki-PlacesTests
//
//  Created by Ana Popilian on 21/06/2026.
//

import Testing
@testable import Wiki_Places


struct PlacesServiceTests {
  private let sut: PlacesService
  private let spy = FactorySpy()
  
  init() {
    sut = PlacesService(factory: spy)
  }
  
  @Test
  func whenFetchPlaces_thenSuccess() async throws {
    //given
    let location1 = Dto.Location(name: "Amsterdam", lat: 10, long: 20.0)
    let location2 = Dto.Location(name: nil, lat: 20, long: 30.0)
    let dto = Dto.LocationResponse(locations: [location1, location2])
    spy.placesWebServiceSpy.fetchPlacesResult = .success(dto)
    
    //when
    let result = await sut.fetchPlaces()
    
    //then
    guard
      case let .success(models) = result else {
      Issue.record("Response should be a success and 1 model returned")
      return
    }
    
    #expect(models.count == 2)
    let expectedModel1 = Model.Place(title: "Amsterdam", description: nil, thumbnailImageUrl: nil, location: .init(latitude: 10, longitude: 20.0, spanDistance: 10_000))
    let expectedModel2 = Model.Place(title: "Unknown", description: nil, thumbnailImageUrl: nil, location: .init(latitude: 20, longitude: 30.0, spanDistance: 10_000))
    
    #expect(models.first! == expectedModel1)
    #expect(models.last! == expectedModel2)
  }
  
  @Test
  func whenSearchAndFetchPlacesBy_thenSuccess() async {
    let coordinate = Dto.WikipediaSearchResponse.Coordinate(lat: 10,
                                                            lon: 20,
                                                            dim: "20")
    let dtoPage = Dto.WikipediaSearchResponse.Page(title: "title",
                                                   coordinates: [coordinate],
                                                   thumbnail: nil,
                                                   description: "description")
    let dto = Dto.WikipediaSearchResponse(query: .init(pages: ["test": dtoPage]))
    spy.placesWebServiceSpy.searchAndFetchPlacesByResult = .success(dto)
    
    let result = await sut.searchAndFetchPlacesBy("Amsterdam")
    
    guard
      case let .success(models) = result,
      let model = models.first else {
      Issue.record("Response should be a success and 1 model returned")
      return
    }
    
    #expect(spy.placesWebServiceSpy.passedSearchTerm == "Amsterdam")
    
    let expectedModel = Model.Place(title: "title", description: "description", thumbnailImageUrl: nil, location: .init(latitude: 10, longitude: 20, spanDistance: 20))
    
    #expect(model == expectedModel)
  }
  
  @Test
  func givenMissingQueryInResponse_whenSearchAndFetchPlacesBy_thenReturnEmptyList() async {
    //given
    let dto = Dto.WikipediaSearchResponse(query: nil)
    spy.placesWebServiceSpy.searchAndFetchPlacesByResult = .success(dto)
    
    //when
    let result = await sut.searchAndFetchPlacesBy("Amsterdam")
    
    //then
    guard case let .success(models) = result else {
      Issue.record("Response should be a success")
      return
    }
    
    #expect(models.isEmpty)
  }
}
