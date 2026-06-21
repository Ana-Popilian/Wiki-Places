//
//  RequestComposerSpy.swift
//  Wiki-PlacesTests
//
//  Created by Ana Popilian on 21/06/2026.
//

import Foundation
@testable import Wiki_Places

final class RequestComposerSpy: RequestComposerInterface {
  var factory: ServiceFactorable = FactorySpy()
  var passedRoute: ApiRouteInterface!
}

// MARK: - RequestComposerInterface
extension RequestComposerSpy {
 
  func composeRequest(from route: ApiRouteInterface) throws -> URLRequest {
    passedRoute = route

    return URLRequest(url: URL(string: "test")!)
  }
}
