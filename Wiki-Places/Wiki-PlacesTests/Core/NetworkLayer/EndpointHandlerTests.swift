//
//  EndpointHandlerTests.swift
//  Wiki-PlacesTests
//
//  Created by Ana Popilian on 21/06/2026.
//

import Testing
@testable import Wiki_Places

struct RequestHandlerTests {
  private let sut: RequestHandler
  private let spy = FactorySpy()
  
  init() {
    sut = RequestHandler(factory: spy)
  }
  
  
  @Test
  func whenRequestData_thenSuccess() async  {
    let testDto = TestDto(id: 123)
    spy.session.dataResult = (testDto, Mock.urlResponse(statusCode: 200))
    let result: Result<TestDto, NetworkError> = await sut.request(TestAPI.generalPlain)
    
    if case let .success(resultData) = result {
      #expect(resultData.id == testDto.id)
      return
    }
    
    Issue.record("Request data shouldn't fail for generalPlain route")
  }
  
  @Test
  func givenUnauthorizedCodeResponse_whenRequestData_thenUnauthorized() async  {
    let testDto = TestDto(id: 123)
    spy.session.dataResult = (testDto, Mock.urlResponse(statusCode: 401))
    let result: Result<TestDto, NetworkError> = await sut.request(TestAPI.generalPlain)
    
    if case let .failure(error) = result {
      #expect(error == .unauthorised)
      return
    }
    
    Issue.record("Request data shouldn't fail for generalPlain route")
  }
  
  
  //TODO: Add more tests, for code coverage
}
