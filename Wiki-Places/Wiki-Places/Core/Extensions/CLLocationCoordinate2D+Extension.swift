//
//  CLLocationCoordinate2D+Extension.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 21/06/2026.
//

import MapKit

extension CLLocationCoordinate2D: @retroactive Equatable {
  public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    lhs.latitude == rhs.latitude &&
    lhs.longitude == rhs.longitude
  }
}
