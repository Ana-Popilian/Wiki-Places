//
//  RequestComposer.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//

import Foundation

protocol RequestComposerInterface: Factorable {
  func composeRequest(from requestTypeInterface: ApiRouteInterface) throws -> URLRequest
}

struct RequestComposer: RequestComposerInterface {
  var factory: ServiceFactorable
  
  func composeRequest(from route: ApiRouteInterface) throws -> URLRequest {
    var request = makeURL(from: route)
    
    request = try factory.parameterEncoder.encode(urlRequest: request, withTask: route.task)
    request.httpMethod = route.httpMethod.rawValue
    request.allHTTPHeaderFields = route.headers
    
    NetworkLogger.log(request: request)
    
    return request
  }
}

// MARK: - Private
private extension RequestComposer {
  func makeURL(from route: ApiRouteInterface) -> URLRequest {
    return URLRequest(url: route.baseURL!.appendingPathComponent(route.path),
                      cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
  }
}
