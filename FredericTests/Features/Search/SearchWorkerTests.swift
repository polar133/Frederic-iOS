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
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Get artists File
    func loadOkData() -> Data? {
        let bundle = Bundle(for: SearchWorkerTests.classForCoder())
        let jsonFile =  bundle.path(forResource: "get_search_200", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!), options: [])
        return data
    }

    func loadOkResponse() -> ArtistsResponse? {
        let data = loadOkData()
        let serialized = try? JSONDecoder().decode(ArtistsResponse.self, from: data!)
        return serialized
    }

    // MARK: Tests
    func testGetSearchSuccess() {
        // Given
        var response: Persons?
        let expected = loadOkResponse()
        let expectation = self.expectation(description: "get artists")

        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: FredericAPI.search)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, self.loadOkData())
        }

        sut = SearchWorker(urlSession: urlSession)

        // When
        sut.doSearch { result in
            switch result {
            case .success(let data):
                response = data.artists
            case .failure(_):
                break
            }
            expectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(response)
        XCTAssertEqual(response, expected?.artists)
    }
}
