//
//  Dto.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//

import Foundation

enum Dto {
  // MARK: - LocationResponse
  struct LocationResponse: Decodable {
    let locations: [Location]
  }
  
  // MARK: - Location
  struct Location: Decodable {
    let name: String?
    let lat: Double
    let long: Double
  }
  
  
  // MARK: - WikipediaSearchResponse
  struct WikipediaSearchResponse: Codable {
    let query: Query?
    
    // MARK: - Query
    struct Query: Codable {
      let pages: [String: Page]
    }
    
    // MARK: - Page
    struct Page: Codable {
      let title: String
      let coordinates: [Coordinate]
      let thumbnail: Thumbnail?
      let description: String?
    }
    
    // MARK: - Coordinate
    struct Coordinate: Codable {
      let lat: Double
      let lon: Double
      let dim: String?
    }
    
    // MARK: - Thumbnail
    struct Thumbnail: Codable {
      let imageUrl: URL
      
      enum CodingKeys: String, CodingKey {
        case imageUrl = "source"
      }
    }
  }
}
