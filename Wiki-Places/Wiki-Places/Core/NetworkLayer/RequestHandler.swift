//
//  RequestHandler.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//

import Foundation
import OSLog

protocol RequestHandlerInterface: Factorable {
  @concurrent func request<T: Decodable>(_ route: ApiRouteInterface, decoder: JSONDecoder) async -> Result<T, NetworkError>
}

struct RequestHandler: RequestHandlerInterface {
  var factory: ServiceFactorable
  
  @concurrent func request<T: Decodable>(
    _ route: ApiRouteInterface,
    decoder: JSONDecoder = JSONDecoder()) async -> Result<T, NetworkError> {
      
      let result = await requestData(route)
      switch result {
      case let .success(data):
        return decodeObject(from: data, using: decoder)
        
      case let .failure(error):
        return .failure(error)
      }
    }
}


// MARK: - Private
private extension RequestHandler {
  @concurrent func requestData(_ route: ApiRouteInterface) async -> Result<Data, NetworkError> {
    
    let session = factory.urlSession
    defer {
      (session as? URLSession)?.finishTasksAndInvalidate()
    }
    do {
      let request = try factory.requestComposer.composeRequest(from: route)
      
      let (data, response) = try await session.data(for: request, delegate: nil)
      guard let httpResponse = response as? HTTPURLResponse else {
        return .failure(.internalError)
      }
      
      guard 200..<300 ~= httpResponse.statusCode else {
        Logger.network.debug("Response data: \(String(decoding: data, as: UTF8.self))")
        
        let error = networkError(fromCode: httpResponse.statusCode)
        return .failure(error)
      }
      
      return .success(data)
    } catch {
      return .failure(networkError(from: error))
    }
  }
}

protocol URLSessionInterface {
  @concurrent func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionInterface {}
