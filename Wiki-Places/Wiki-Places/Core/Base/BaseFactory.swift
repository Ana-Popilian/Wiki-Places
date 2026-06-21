//
//  BaseFactory.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 19/06/2026.
//


import Foundation

class BaseFactory {
  var factory: ServiceFactorable
  
  init(factory: ServiceFactorable = ServiceFactory()) {
    self.factory = factory
  }
}
