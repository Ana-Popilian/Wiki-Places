//
//  Dto+ModelMapping.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 20/06/2026.
//

import Foundation
import OSLog


// MARK: - Private Dto.Location
extension Dto.Location {
  var model: Model.Place {
    let location = Model.Location(latitude: lat,
                                  longitude: long,
                                  spanDistance: 10_000)

    return .init(title: name ?? "Unknown",
                 description: nil,
                 thumbnailImageUrl: nil,
                 location: location)
  }
}


// MARK: - Private Dto.Location
extension Dto.WikipediaSearchResponse.Page {
  var model: Model.Place? {
    guard let coordinate = coordinates.first else {
      assertionFailure("[INVESTIGATE] Missing coordinates for place with title: \(title)")
      Logger.main.trace("[INVESTIGATE] Missing coordinates for place with title: \(title)")
      return nil
    }

    var spanDistance: Double = 10_000
    if let spanString = coordinate.dim {
      spanDistance = Double(spanString) ?? spanDistance
    }

    let location = Model.Location(latitude: coordinate.lat,
                                  longitude: coordinate.lon,
                                  spanDistance: spanDistance)
    
    return Model.Place(title: title,
                       description: description,
                       thumbnailImageUrl: thumbnail?.imageUrl,
                       location: location)
  }
}
