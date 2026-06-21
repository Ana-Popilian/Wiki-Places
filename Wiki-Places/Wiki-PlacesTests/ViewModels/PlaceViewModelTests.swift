//
//  PlaceViewModelTests.swift
//  Wiki-PlacesTests
//
//  Created by Ana Popilian on 21/06/2026.
//

import Foundation
import Testing
@testable import Wiki_Places

@MainActor
struct PlaceViewModelTests {
  private let sut: PlaceViewModel
  private let spy = FactorySpy()

  init() {
    sut = PlaceViewModel(factory: spy)
  }

  @Test
  func whenTapOnMap_thenSuccess() {
    let expectedResult = Model.Location(latitude: 245, longitude: 10, spanDistance: 10_000)

    sut.didTapOnMap(latitude: 245, longitude: 10)

    #expect(expectedResult == sut.selectedLocation)
  }

  @Test
  func whenDidTapSearchButton_thenSuccess() {
    sut.didTapSearchButton()

    #expect(sut.isSearchListPresented == true)
    #expect(sut.isDiscoverOnWikipediaButtonVisible == false)
  }

  @Test
  func whenDiscoverInWikipedia_thenSuccess() {
    sut.selectedLocation = .init(latitude: 248, longitude: 12, spanDistance: 100)
    spy.deepLinkUrlComposerSpy.makeDeepLinkUrlForResult = URL(string: "wikipedia-official://")

    sut.discoverInWikipedia()

    #expect(spy.deepLinkUrlComposerSpy.passedLocation == sut.selectedLocation)
  }
}
