//
//  PlaceViewModel.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 20/06/2026.
//

import SwiftUI
import OSLog
import MapKit

@Observable
@MainActor
final class PlaceViewModel: BaseFactory {
  var position = MapCameraPosition.automatic
  var tappedCoordinate: CLLocationCoordinate2D?
  var isSearchListPresented: Bool = false
  var isDiscoverOnWikipediaButtonVisible: Bool = false
  var selectedLocation: Model.Location?

  func didTapOnMap(latitude: Double, longitude: Double) {
    selectedLocation = Model.Location(latitude: latitude, longitude: longitude, spanDistance: 10_000)
  }

  func didTapSearchButton() {
    isSearchListPresented = true
    isDiscoverOnWikipediaButtonVisible = false
  }

  func discoverInWikipedia() {
    guard let location = selectedLocation else {
      return
    }

    let url = factory.deepLinkUrlComposer.makeDeepLinkUrlFor(location)

    guard let url else {
      return
    }

    guard UIApplication.shared.canOpenURL(url) else {
      assertionFailure("[INVESTIGATE] Can't open deepLink url \(url.absoluteString)")
      Logger.main.trace("[INVESTIGATE] Can't open deepLink url \(url.absoluteString)")
      return
    }

    UIApplication.shared.open(url)
  }
}
