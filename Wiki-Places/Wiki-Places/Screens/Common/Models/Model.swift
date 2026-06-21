//
//  Model.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 20/06/2026.
//

import Foundation

enum Model {
  struct Place: Identifiable {
    let id: UUID = .init()
    let title: String
    let description: String?
    let thumbnailImageUrl: URL?
    let location: Location
  }
  
  struct Location {
    let latitude: Double
    let longitude: Double
    let spanDistance: Double
  }
}
