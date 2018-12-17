//
//  ImageTests.swift
//  iMarvelTests
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import XCTest
@testable import iMarvel

class ImageTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetLandscapeUrl() {
        guard let landscapeUrl = ImageManager.shared.getLandscapeUrlWith("http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", ext: "jpg")  else {
            XCTFail("impossible to get the url")
            return
        }
        XCTAssertEqual("http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784/landscape_amazing.jpg", landscapeUrl.absoluteString)
    }

}
