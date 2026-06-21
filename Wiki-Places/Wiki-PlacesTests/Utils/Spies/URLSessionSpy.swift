//
//  URLSessionSpy.swift
//  Wiki-PlacesTests
//
//  Created by Ana Popilian on 21/06/2026.
//

import Foundation
@testable import Wiki_Places

final class URLSessionSpy: @unchecked Sendable {
  var passedRequest: URLRequest!
  
  var dataResult: (TestDto, URLResponse)!
  var error: NSError?
}

extension URLSessionSpy: URLSessionInterface {
  @concurrent func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
    passedRequest = request
    if let error {
      throw error
    }
    
    let result = (try! JSONEncoder().encode(dataResult.0), dataResult.1)
    return result
  }
}
