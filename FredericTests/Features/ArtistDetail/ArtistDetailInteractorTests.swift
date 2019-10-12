//
//  ArtistDetailInteractorTests.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

@testable import Frederic
import XCTest

// swiftlint:disable all
class ArtistDetailInteractorTests: XCTestCase {
  // MARK: Subject under test

  var sut: ArtistDetailInteractor!

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupArtistDetailInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupArtistDetailInteractor() {
    sut = ArtistDetailInteractor()
  }

  // MARK: Test doubles

  class ArtistDetailPresentationLogicSpy: ArtistDetailPresentationLogic {
    var presentSomethingCalled = false

    func presentSomething(response: ArtistDetail.Something.Response) {
      presentSomethingCalled = true
    }
  }

  // MARK: Tests

  func testDoSomething() {
    // Given
    let spy = ArtistDetailPresentationLogicSpy()
    sut.presenter = spy
    let request = ArtistDetail.Something.Request()

    // When
    sut.doSomething(request: request)

    // Then
    XCTAssertTrue(spy.presentSomethingCalled, "doSomething(request:) should ask the presenter to format the result")
  }
}
