//
//  ParameterEncoderTests.swift
//  Wiki-PlacesTests
//
//  Created by Ana Popilian on 21/06/2026.
//

import Foundation
import Testing
@testable import Wiki_Places


struct ParameterEncoderTests {
  private let spy = FactorySpy()
  private let sut: ParameterEncoder

  private let urlRequest = URLRequest(url: URL(string: "www.google.com")!)

  init() {
    sut = ParameterEncoder(factory: spy)
  }

  @Test
  func givenTaskNone_whenEncode_thenReturnSameRequest() async throws {
    let result = try sut.encode(urlRequest: urlRequest, withTask: .none)

    #expect(result == urlRequest)
  }

  @Test
  func givenTaskBody_whenEncode_thenReturnRequestWithBody() async throws {
    let dto = TestDto(id: 20)
    let expectedResult = try JSONEncoder().encode(dto)

    let result = try sut.encode(urlRequest: urlRequest, withTask: .body(dto))

    #expect(result.httpBody == expectedResult)
  }

  @Test
  func givenTaskUrl_whenEncode_thenReturnRequestWithQueryUrl() async throws {
    let parameters = ["Id": "20", "lat": "200"]

    let result = try sut.encode(urlRequest: urlRequest, withTask: .url(parameters))

    let resultUrl = try #require(result.url)
    #expect(resultUrl.absoluteString.contains("lat=200"))
    #expect(resultUrl.absoluteString.contains("Id=20"))
  }
}
