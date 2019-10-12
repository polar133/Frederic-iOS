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
        XCTAssertTrue(spy.presentSearchResultCalled, "doSomething(request:) should ask the presenter to format the result")
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

class SearchPresentationLogicSpy: SearchPresentationLogic {
    var presentSearchResultCalled = false

    func presentSearchResult(response: Search.Artists.Response) {
        presentSearchResultCalled = true
    }
}

