//
//  DeeplinkComposerSpy.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 21/06/2026.
//

import Foundation
@testable import Wiki_Places

final class DeepLinkComposerSpy: @unchecked Sendable {
  var passedLocation: Model.Location!
  var makeDeepLinkUrlForResult: URL?
}

// MARK: - DeepLinkUrlComposerInterface
extension DeepLinkComposerSpy: DeepLinkUrlComposerInterface {
  func makeDeepLinkUrlFor(_ location: Model.Location) -> URL? {
    passedLocation = location
    return makeDeepLinkUrlForResult
  }
}
