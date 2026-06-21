//
//  RequestHandler+Decoding.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//

import Foundation
import OSLog

extension RequestHandler {
  func decodeObject<T: Decodable>(from data: Data?, using decoder: JSONDecoder) -> Result<T, NetworkError> {
    guard let data else {
      return .failure(.invalidParameters)
    }
    
    do {
      let decodedObject = try decoder.decode(T.self, from: data)
      return .success(decodedObject)
    } catch {
      Logger.network.warning("Could NOT decode object of type \(T.self),\nerror: \(error)\ndata: \(String(decoding: data, as: UTF8.self))")
      return .failure(.decodingError)
    }
  }
}
