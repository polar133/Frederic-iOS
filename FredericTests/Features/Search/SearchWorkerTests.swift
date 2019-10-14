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

    func loadDataFromFile(_ name: String) -> Data? {
        let bundle = Bundle(for: SearchWorkerTests.classForCoder())
        let jsonFile =  bundle.path(forResource: name, ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFile!), options: [])
        return data
    }
    // MARK: Get artists Response
    func loadOkResponse() -> ArtistsResponse? {
        let data = loadDataFromFile("get_search_200")
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

        // config URL Mock
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: FredericAPI.search)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, self.loadDataFromFile("get_search_200"))
        }

        sut = SearchWorker(urlSession: urlSession)

        // When
        sut.doSearch(search: "frederic") { result in
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

    func testGetSearchFailure() {
        // Given
        let expectation = self.expectation(description: "failed getting artists")
        var response: FredericError?
        let expected = FredericError.unknown

        // config URL Mock
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: FredericAPI.search)!, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, self.loadDataFromFile("get_search_400"))
        }

        sut = SearchWorker(urlSession: urlSession)

        // When
        sut.doSearch(search: "frederic") { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                response = error
                break
            }
            expectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(response)
        XCTAssertEqual(response, expected)
    }

    func testGetSearchBadResponse() {
        // Given
        let expectation = self.expectation(description: "fail parse")
        var response: FredericError?
        let expected = FredericError.responseSerialization

        // config URL Mock
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: FredericAPI.search)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, self.loadDataFromFile("get_search_400"))
        }

        sut = SearchWorker(urlSession: urlSession)

        // When
        sut.doSearch(search: "frederic") { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                response = error
                break
            }
            expectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(response)
        XCTAssertEqual(response, expected)
    }

}
