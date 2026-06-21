//
//  FactorySpy.swift
//  Wiki-PlacesTests
//
//  Created by Ana Popilian on 21/06/2026.
//

import Foundation
@testable import Wiki_Places

struct FactorySpy {
  let session = URLSessionSpy()
  let placesWebServiceSpy = PlacesWebServiceSpy()
  let placesServiceSpy = PlacesServiceSpy()
  let deepLinkUrlComposerSpy = DeepLinkComposerSpy()
}


// MARK: - ServiceFactorable
extension FactorySpy: ServiceFactorable {
  var urlSession: any URLSessionInterface {
    session
  }
  
  var placesWebService: any PlacesWebServiceInterface {
    placesWebServiceSpy
  }
  
  var placesService: any PlacesServiceInterface {
    placesServiceSpy
  }

  var deepLinkUrlComposer: any DeepLinkUrlComposerInterface {
    deepLinkUrlComposerSpy
  }
}
