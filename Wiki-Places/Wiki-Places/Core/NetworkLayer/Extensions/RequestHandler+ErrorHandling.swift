//
//  RequestHandler+ErrorHandling.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//

import Foundation
import OSLog

extension RequestHandler {
  func networkError(fromCode statusCode: Int) -> NetworkError {
    Logger.network.trace("Status code \(statusCode)")
    if 401...403 ~= statusCode {
      return .unauthorised
    }

    return .internalError
  }

  func networkError(from error: Error) -> NetworkError {
    if let error = error as? NetworkError {
      return error
    }

    guard let errorCode = error.errorCode else {
      return .internalError
    }
    Logger.network.debug("Status code \(errorCode)")
    switch errorCode {
    case 401...403:
      return .unauthorised

    case -999:
      return .cancelled

    case -1009, -1020:
      return .networkError

    case -1001:
      return .timeout

    default:
      return .internalError
    }
  }
}

extension Error {
  var errorCode: Int? {
    return (self as NSError).code
  }
}
