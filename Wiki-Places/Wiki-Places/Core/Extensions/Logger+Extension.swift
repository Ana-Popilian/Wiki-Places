//
//  Logger+Extension.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//

import OSLog

extension Logger {
  private static let subsystem = Bundle.main.bundleIdentifier!
  
  static let network = Logger(subsystem: subsystem, category: "network")
  
  static let main = Logger(subsystem: subsystem, category: "main")
}
