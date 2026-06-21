//
//  RequestHandlerDelegate.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//

import Foundation

final class RequestHandlerDelegate: NSObject, URLSessionDelegate {
  func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    
      // Do the custom SSL pinning here, pin the intermediate certificate public key hash for better rotation strategy, as Apple recommends
      return completionHandler(.useCredential, challenge.proposedCredential)
  }
}
