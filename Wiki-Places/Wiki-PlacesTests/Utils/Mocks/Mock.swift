//
//  Mocks.swift
//  Wiki-PlacesTests
//
//  Created by Ana Popilian on 21/06/2026.
//

import Foundation
@testable import Wiki_Places

enum Mock {
  static func urlResponse(statusCode: Int) -> HTTPURLResponse {
    HTTPURLResponse(url: URL(string: "test")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
  }
  
  static let place = Model.Place(title: "test", description: nil, thumbnailImageUrl: nil, location: Model.Location(latitude: 10, longitude: 20, spanDistance: 30))
}

enum TestAPI {
  case generalPlain
  case generalGET(_ dto: TestDto, token: String)
  case generalPOST(_ parameters: [String: String])
}

struct TestDto: Codable {
  let id: Double
}

extension TestAPI: ApiRouteInterface {
  var baseURL: URL? {
    URL(string: "www.google.com")
  }
  
  var path: String {
    switch self {
    case .generalPlain,
        .generalGET,
        .generalPOST:
      return "test"
    }
  }
  
  var httpMethod: HTTPMethod {
    switch self {
    case .generalPlain,
        .generalGET:
      return .GET
      
    case .generalPOST:
      return .POST
    }
  }
  
  var task: HTTPTask {
    switch self {
    case .generalPlain:
      return .none
      
    case let .generalGET(dto, _):
      return .body(dto)
      
    case let .generalPOST(dto):
      return .url(dto)
    }
  }
  
  var headers: [String: String] {
    ["Content-Type": "application/json"]
  }
}
