//
//  Models+Equatable.swift
//  Wiki-PlacesTests
//
//  Created by Ana Popilian on 20/06/2026.
//

import Foundation
@testable import Wiki_Places

extension Model.Place: @retroactive Equatable {
  public static func == (lhs: Model.Place, rhs: Model.Place) -> Bool {
    lhs.title == rhs.title &&
    lhs.description == rhs.description &&
    lhs.thumbnailImageUrl == rhs.thumbnailImageUrl &&
    lhs.location == rhs.location
  }
}

extension Model.Location: @retroactive Equatable {
  public static func == (lhs: Model.Location, rhs: Model.Location) -> Bool {
    lhs.latitude == rhs.latitude &&
    lhs.longitude == rhs.longitude &&
    lhs.spanDistance == rhs.spanDistance
  }
}
