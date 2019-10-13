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
    var artist: Artist!
    
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

    func testPresentSomething() {
        // Given
        let spy = ArtistDetailDisplayLogicSpy()
        sut.viewController = spy
        let response = ArtistDetail.Profile.Response(artist: self.artist)

        // When
        sut.presentArtist(response: response)

        // Then
        XCTAssertTrue(spy.displayArtistCalled)
    }
}

class ArtistDetailDisplayLogicSpy: ArtistDetailDisplayLogic {
    var displayArtistCalled = false

    func displayArtist(viewModel: ArtistDetail.Profile.ViewModel) {
        displayArtistCalled = true
    }
}
