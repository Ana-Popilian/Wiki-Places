//
//  AppConfiguration.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//

import Foundation

enum AppConfiguration {
  static let defaultHeaders =  [
    "Content-Type": "application/json",
    "Accept": "application/json"]
  
  static let requestTimeoutLimit: TimeInterval = 30.0 //seconds
}
