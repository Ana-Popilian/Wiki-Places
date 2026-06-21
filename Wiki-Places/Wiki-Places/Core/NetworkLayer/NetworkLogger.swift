//
//  NetworkLogger.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//

import Foundation
import OSLog

enum NetworkLogger {
  
#if DEBUG
  //testing purpose
  static func log(request: URLRequest) {
    
    print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
    defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
    
    let urlAsString = request.url?.absoluteString ?? ""
    let urlComponents = NSURLComponents(string: urlAsString)
    
    let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
    let path = "\(urlComponents?.path ?? "")"
    let query = "\(urlComponents?.query ?? "")"
    let host = "\(urlComponents?.host ?? "")"
    
    var logOutput = """
    \(urlAsString) \n\n
    \(method) \(path)?\(query) HTTP \n
    HOST: \(host)\n
    """
    for (key, value) in request.allHTTPHeaderFields ?? [:] {
      logOutput += "\(key): \(value) \n"
    }
    
    Logger.network.debug("\(logOutput)")
  }
#else
  static func log(request: URLRequest) {}
#endif
}
