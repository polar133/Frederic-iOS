//
//  SearchWorkerTests.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

@testable import Frederic
import XCTest

// swiftlint:disable all
class SearchWorkerTests: XCTestCase {
  // MARK: Subject under test

  var sut: SearchWorker!

  // MARK: Test lifecycle

  override func setUp() {
    super.setUp()
    setupSearchWorker()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: Test setup

  func setupSearchWorker() {
    sut = SearchWorker()
  }

  // MARK: Test doubles

  // MARK: Tests

  func testSomething() {
    // Given

    // When

    // Then
  }
}
