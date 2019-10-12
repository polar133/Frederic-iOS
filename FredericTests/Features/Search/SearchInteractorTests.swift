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

    // MARK: Tests

    func testSearch() {
        // Given
        let spy = SearchPresentationLogicSpy()
        let workerspy = SearchWorkerSuccessSpy()
        sut.worker = workerspy
        sut.presenter = spy
        let request = Search.Artists.Request(search: "frederic")

        // When
        sut.search(request: request)

        // Then
        XCTAssertTrue(spy.presentLoadingCalled)
        XCTAssertTrue(spy.presentSearchResultCalled)
    }

    func testLessWordsInSearch() {
        // Given
        let spy = SearchPresentationLogicSpy()
        sut.presenter = spy
        let request = Search.Artists.Request(search: "fr")

        // When
        sut.search(request: request)

        // Then
        XCTAssertFalse(spy.presentSearchResultCalled)
        XCTAssertFalse(spy.presentLoadingCalled)
        XCTAssertFalse(spy.presentErrorResultCalled)
    }

    func testErrorSearch() {
        // Given
        let spy = SearchPresentationLogicSpy()
        let workerspy = SearchWorkerErrorSpy()
        sut.worker = workerspy
        sut.presenter = spy
        let request = Search.Artists.Request(search: "frederic")

        // When
        sut.search(request: request)

        // Then
        XCTAssertTrue(spy.presentLoadingCalled)
        XCTAssertFalse(spy.presentSearchResultCalled)
        XCTAssertTrue(spy.presentErrorResultCalled)
    }

    func testSelectArtist() {
        // Given
        let spy = SearchPresentationLogicSpy()
        sut.presenter = spy
        sut.artist = nil
        let workerspy = SearchWorkerSuccessSpy()
        sut.worker = workerspy
        let request = Search.Artists.Request(search: "frederic")
        sut.search(request: request)

        // When
        sut.selectArtist(id: 11539849)

        // Then
        XCTAssertTrue(spy.presentArtistDetailCalled)
        XCTAssertNotNil(sut.artist)
    }

    func testSelectArtistWithoutArtists() {
        // Given
        let spy = SearchPresentationLogicSpy()
        sut.presenter = spy
        sut.artist = nil
        // When
        sut.selectArtist(id: 11539849)

        // Then
        XCTAssertFalse(spy.presentArtistDetailCalled)
        XCTAssertNil(sut.artist)
    }

}

class SearchPresentationLogicSpy: SearchPresentationLogic {
    var presentSearchResultCalled = false
    var presentLoadingCalled = false
    var presentErrorResultCalled = false
    var presentArtistDetailCalled = false

    func presentSearchResult(response: Search.Artists.Response) {
        presentSearchResultCalled = true
    }

    func presentLoading() {
        presentLoadingCalled = true
    }

    func presentErrorResult() {
        presentErrorResultCalled = true
    }

    func presentArtistDetail() {
        presentArtistDetailCalled = true
    }
}

class SearchWorkerSuccessSpy: SearchWorker {
    override func doSearch(search: String, callback: @escaping (Result<ArtistsResponse>) -> Void) {
        let bundle = Bundle(for: SearchInteractorTests.classForCoder())
        let jsonFile =  bundle.path(forResource: "get_search_200", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!), options: [])
        let serialized = try? JSONDecoder().decode(ArtistsResponse.self, from: data!)
        callback(.success(serialized!))
    }
}

class SearchWorkerErrorSpy: SearchWorker {
    override func doSearch(search: String, callback: @escaping (Result<ArtistsResponse>) -> Void) {
        callback(.failure(.noInternetConection))
    }
}

