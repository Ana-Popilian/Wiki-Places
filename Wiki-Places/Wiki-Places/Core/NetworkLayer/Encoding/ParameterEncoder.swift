//
//  ParametersEncoder.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//

import Foundation

protocol ParameterEncoderInterface: Factorable {
  func encode(urlRequest: URLRequest, withTask task: HTTPTask) throws -> URLRequest
}

struct ParameterEncoder: ParameterEncoderInterface {
  var factory: any ServiceFactorable
  
  func encode(urlRequest: URLRequest, withTask task: HTTPTask) throws -> URLRequest {
    switch task {
    case .none:
      return urlRequest
      
    case let .body(dto):
      return try encode(urlRequest, withBody: dto)
      
    case let .url(parameters):
      return try encode(urlRequest, with: parameters)
    }
  }
}

// MARK: - Private
private extension ParameterEncoder {
  func encode(_ urlRequest: URLRequest, with parameters: [String: String]) throws -> URLRequest {
    guard let url = urlRequest.url else {
      throw NetworkError.missingURL
    }
    
    if (parameters.isEmpty) {
      throw NetworkError.invalidParameters
    }
    
    var urlRequest = urlRequest
    
    guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      return urlRequest
    }
    
    urlComponents.queryItems = [URLQueryItem]()
    for (key, value) in parameters {
      let queryItem = URLQueryItem(name: key, value:"\(value)")
      urlComponents.queryItems?.append(queryItem)
    }
    
    urlRequest.url = urlComponents.url
    return urlRequest
  }
  
  func encode(_ urlRequest: URLRequest, withBody bodyDto: Encodable) throws -> URLRequest {
    var urlRequest = urlRequest
    do {
      let encoder = JSONEncoder()
      urlRequest.httpBody = try encoder.encode(bodyDto)
      return urlRequest
    } catch {
      throw NetworkError.encodingFailed
    }
  }
}
