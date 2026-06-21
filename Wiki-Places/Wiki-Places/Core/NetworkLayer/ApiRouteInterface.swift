//
//  ApiRouteInterface.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//

import Foundation

protocol ApiRouteInterface {
  var baseURL: URL? { get }
  var path: String { get }
  var httpMethod: HTTPMethod { get }
  var task: HTTPTask { get }
  var headers: [String: String] { get }
}

extension ApiRouteInterface {
  var headers: [String: String] { AppConfiguration.defaultHeaders }
}

enum HTTPMethod: String, CaseIterable {
  case GET
  case POST
  case PUT
  case PATCH
  case DELETE
}

enum HTTPTask {
  case none
  case body(_ parameter: Encodable)
  case url(_ parameters: [String: String])
}

enum NetworkError: Error, CaseIterable {
  case encodingFailed
  case missingURL
  case decodingError
  case invalidParameters
  case internalError
  case networkError
  case cancelled
  case unauthorised
  case timeout
  // other to be added if needed

  var description: String {
    switch self {
    case .encodingFailed:
      return "Parameter encoding failed"

    case .missingURL:
      return "URL is nil"

    case .decodingError:
      return "Decoding failed"

    case .invalidParameters:
      return "Invalid Parameters"

    case .internalError:
      return "Internal Error"

    case .networkError:
      return "Network Error"

    case .cancelled:
      return "Cancelled"

    case .unauthorised:
      return "Unauthorised"

    case .timeout:
      return "Timeout"
    }
  }
}
