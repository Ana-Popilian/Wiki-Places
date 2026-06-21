//
//  LocationAPI.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//

import Foundation

enum LocationAPI {
  case fetchPlaces(_ fileName: String)
  case searchAndFetchPlaces(_ urlParameters: [String: String])
}


// MARK: - APIRouteInterface
extension LocationAPI: ApiRouteInterface {
  var baseURL: URL? {
    switch self {
    case .fetchPlaces:
      return URL(string: "https://raw.githubusercontent.com/")
      
    case .searchAndFetchPlaces:
      return URL(string: "https://en.wikipedia.org/")
    }
  }
  
  var path: String {
    switch self {
    case .fetchPlaces(let fileName):
      return "abnamrocoesd/assignment-ios/main/\(fileName)"
      
    case .searchAndFetchPlaces:
      return "w/api.php"
    }
  }
  
  var httpMethod: HTTPMethod {
    .GET
  }
  
  var task: HTTPTask {
    switch self {
    case .fetchPlaces:
      return .none
      
    case .searchAndFetchPlaces(let parameters):
      return .url(parameters)
    }
  }
}
