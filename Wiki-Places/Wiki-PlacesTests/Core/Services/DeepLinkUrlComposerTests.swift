//
//  DeepLinkUrlComposerTests.swift
//  Wiki-PlacesTests
//
//  Created by Ana Popilian on 20/06/2026.
//

import Foundation
import Testing
@testable import Wiki_Places


struct DeepLinkUrlComposerTests {
  private let sut: DeepLinkUrlComposer
  
  init() {
    sut = DeepLinkUrlComposer()
  }
  
  @Test
  func whenMakeDeepLinkUrlFor_thenSuccess() throws {
    
    let optionalUrl = sut.makeDeepLinkUrlFor(Mock.place.location)
    
    let url = try #require(optionalUrl)
    #expect(url.absoluteString == "wikipedia-official://places/api/?latitude=10.0&longitude=20.0&spanDistance=30.0")
  }
}
