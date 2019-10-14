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
    var artist: Artist!

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
        artist = Artist(id: 123,
                        forename: "Frédéric",
                        surname: "Chopin",
                        name: "Frédéric Chopin",
                        functions: ["Composer"],
                        popularity: 5.0,
                        score: 5.0,
                        kind: nil)
    }

    // MARK: Tests

    func testGetArtist() {
        // Given
        let spy = ArtistDetailPresentationLogicSpy()
        sut.presenter = spy
        sut.artist = self.artist
        let request = ArtistDetail.Profile.Request()

        // When
        sut.getArtist(request: request)

        // Then
        XCTAssertTrue(spy.presentArtistCalled)
    }
}

class ArtistDetailPresentationLogicSpy: ArtistDetailPresentationLogic {
    var presentArtistCalled = false

    func presentArtist(response: ArtistDetail.Profile.Response) {
        presentArtistCalled = true
    }
}
