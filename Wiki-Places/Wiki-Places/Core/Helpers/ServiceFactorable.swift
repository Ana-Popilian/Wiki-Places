//
//  ServicesFactorable.swift
//  Wiki-Places
//
//  Created by Ana Popilian on 20/06/2026.
//

import Foundation
import Network

protocol Factorable {
  var factory: ServiceFactorable { get }
}

//MARK: - Default Factorable
extension Factorable {
  var factory: ServiceFactorable { ServiceFactory() }
}


//MARK: - ServiceFactorable
protocol ServiceFactorable: Sendable {
  // Web services
  var placesWebService: PlacesWebServiceInterface { get }

  // Services
  var placesService: PlacesServiceInterface { get }
  var deepLinkUrlComposer: DeepLinkUrlComposerInterface { get }

  // Utilities
  var parameterEncoder: ParameterEncoderInterface { get }
  var requestComposer: RequestComposerInterface { get }
  var requestHandler: RequestHandlerInterface { get }
  var urlSession: URLSessionInterface { get }
}


//MARK: - Default ServiceFactorable
extension ServiceFactorable {
  var placesWebService: PlacesWebServiceInterface {
    PlacesWebService(factory: ServiceFactory())
  }

  var placesService: PlacesServiceInterface {
    PlacesService(factory: ServiceFactory())
  }

  var deepLinkUrlComposer: DeepLinkUrlComposerInterface {
    DeepLinkUrlComposer()
  }

  var parameterEncoder: ParameterEncoderInterface {
    ParameterEncoder(factory: ServiceFactory())
  }

  var requestComposer: RequestComposerInterface {
    RequestComposer(factory: ServiceFactory())
  }

  var requestHandler: RequestHandlerInterface {
    RequestHandler(factory: ServiceFactory())
  }

  var urlSession: URLSessionInterface {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.timeoutIntervalForRequest = AppConfiguration.requestTimeoutLimit
    configuration.timeoutIntervalForResource = AppConfiguration.requestTimeoutLimit
    return URLSession(configuration: configuration,
                      delegate: RequestHandlerDelegate(),
                      delegateQueue: nil)
  }
}


struct ServiceFactory: ServiceFactorable {}
