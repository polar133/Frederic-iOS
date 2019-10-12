//
//  SearchInteractorTests.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

@testable import Frederic
import XCTest

// swiftlint:disable all
class SearchInteractorTests: XCTestCase {
  // MARK: Subject under test

  var sut: SearchInteractor!

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupSearchInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupSearchInteractor() {
    sut = SearchInteractor()
  }

  // MARK: Test doubles

  class SearchPresentationLogicSpy: SearchPresentationLogic {
    var presentSomethingCalled = false

    func presentSomething(response: Search.Artists.Response) {
      presentSomethingCalled = true
    }
  }

  // MARK: Tests

  func testDoSomething() {
    // Given
    let spy = SearchPresentationLogicSpy()
    sut.presenter = spy
    let request = Search.Artists.Request()

    // When
    sut.doSomething(request: request)

    // Then
    XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
  }
}
