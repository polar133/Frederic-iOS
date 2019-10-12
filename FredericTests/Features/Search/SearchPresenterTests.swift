//
//  SearchPresenterTests.swift
//  Frederic
//
//  Created by Carlos Jimenez on 12-10-19.
//  Copyright (c) 2019 Carlos Jimenez. All rights reserved.
//

@testable import Frederic
import XCTest

// swiftlint:disable all
class SearchPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: SearchPresenter!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupSearchPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupSearchPresenter() {
        sut = SearchPresenter()
    }

    // MARK: Test doubles

    class SearchDisplayLogicSpy: SearchDisplayLogic {
        var displaySomethingCalled = false

        func displayArtists(viewModels: [Search.Artists.ViewModel]) {
            displaySomethingCalled = true
        }
    }

    // MARK: Tests

    func testPresentSomething() {
        // Given
        let spy = SearchDisplayLogicSpy()
        sut.viewController = spy
        let response = Search.Artists.Response(artists: Persons(persons: []))

        // When
        sut.presentSearchResult(response: response)

        // Then
        XCTAssertTrue(spy.displaySomethingCalled, "presentSearchResult(response:) should ask the view controller to display the result")
    }
}
