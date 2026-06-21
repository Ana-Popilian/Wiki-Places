//
//  DeepLinkUrlComposer.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 20/06/2026.
//

import Foundation
import OSLog

protocol DeepLinkUrlComposerInterface {
  func makeDeepLinkUrlFor(_ location: Model.Location) -> URL?
}

struct DeepLinkUrlComposer: DeepLinkUrlComposerInterface {

  func makeDeepLinkUrlFor(_ location: Model.Location) -> URL? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "wikipedia-official"
    urlComponents.host = "places"
    urlComponents.path = "/api/"
    urlComponents.queryItems = [
      URLQueryItem(name: "latitude", value: String(location.latitude)),
      URLQueryItem(name: "longitude", value: String(location.longitude)),
      URLQueryItem(name: "spanDistance", value: String(location.spanDistance))
    ]

    guard let url = urlComponents.url else {
      assertionFailure("[INVESTIGATE] deeplink url malformed")
      Logger.main.trace("[INVESTIGATE] deeplink url malformed")
      return nil
    }

    return url
  }
}
