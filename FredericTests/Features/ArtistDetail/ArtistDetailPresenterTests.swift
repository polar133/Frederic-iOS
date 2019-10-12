//
//  ArtistDetailPresenterTests.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

@testable import Frederic
import XCTest

// swiftlint:disable all
class ArtistDetailPresenterTests: XCTestCase {
  // MARK: Subject under test

  var sut: ArtistDetailPresenter!

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupArtistDetailPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupArtistDetailPresenter() {
    sut = ArtistDetailPresenter()
  }

  // MARK: Test doubles

  class ArtistDetailDisplayLogicSpy: ArtistDetailDisplayLogic {
    var displaySomethingCalled = false

    func displaySomething(viewModel: ArtistDetail.Something.ViewModel) {
      displaySomethingCalled = true
    }
  }

  // MARK: Tests

  func testPresentSomething() {
    // Given
    let spy = ArtistDetailDisplayLogicSpy()
    sut.viewController = spy
    let response = ArtistDetail.Something.Response()

    // When
    sut.presentSomething(response: response)

    // Then
    XCTAssertTrue(spy.displaySomethingCalled, "presentSomething(response:) should ask the view controller to display the result")
  }
}
