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

    func loadPersons() -> [Artist] {
        let bundle = Bundle(for: SearchWorkerTests.classForCoder())
        let jsonFile =  bundle.path(forResource: "get_search_200", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!), options: [])
        let serialized = try? JSONDecoder().decode(ArtistsResponse.self, from: data!)
        return serialized?.artists.persons ?? []
    }

    // MARK: Tests

    func testPresentSearchResult() {
        // Given
        let spy = SearchDisplayLogicSpy()
        sut.viewController = spy
        let response = Search.Artists.Response(artists: Persons(persons: loadPersons()))

        // When
        sut.presentSearchResult(response: response)

        // Then
        XCTAssertFalse(spy.displayEmptyStateCalled)
        XCTAssertTrue(spy.displayArtistsCalled)
    }

    func testPresentSearchResultEmpty() {
        // Given
        let spy = SearchDisplayLogicSpy()
        sut.viewController = spy
        let response = Search.Artists.Response(artists: Persons(persons: []))

        // When
        sut.presentSearchResult(response: response)

        // Then
        XCTAssertTrue(spy.displayEmptyStateCalled)
        XCTAssertFalse(spy.displayArtistsCalled)
    }

    func testPresentLoading() {
        // Given
        let spy = SearchDisplayLogicSpy()
        sut.viewController = spy

        // When
        sut.presentLoading()

        // Then
        XCTAssertTrue(spy.displayLoadingCalled)
    }

    func testPresentError() {
        // Given
        let spy = SearchDisplayLogicSpy()
        sut.viewController = spy

        // When
        sut.presentErrorResult()

        // Then
        XCTAssertTrue(spy.displayErrorCalled)
    }

    func testPresentArtistDetail() {
        // Given
        let spy = SearchDisplayLogicSpy()
        sut.viewController = spy

        // When
        sut.presentArtistDetail()

        // Then
        XCTAssertTrue(spy.goToArtistDetailCalled)
    }
}

class SearchDisplayLogicSpy: SearchDisplayLogic {
    var displayArtistsCalled = false
    var displayLoadingCalled = false
    var hideLoadingCalled = false
    var displayEmptyStateCalled = false
    var displayErrorCalled = false
    var hideErrorCalled = false
    var goToArtistDetailCalled = false

    func displayArtists(viewModels: [Search.Artists.ViewModel]) {
        displayArtistsCalled = true
    }

    func displayLoading() {
        displayLoadingCalled = true
    }

    func hideLoading() {
        hideLoadingCalled = true
    }

    func displayError() {
        displayErrorCalled = true
    }

    func hideError() {
        hideErrorCalled = true
    }

    func displayEmptyState() {
        displayEmptyStateCalled = true
    }

    func goToArtistDetail() {
        goToArtistDetailCalled = true
    }
}
