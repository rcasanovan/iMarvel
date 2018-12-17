//
//  EncryptionTests.swift
//  iMarvelTests
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import XCTest
@testable import iMarvel

class EncryptionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMD5() {
        let digest = "\("1545009619.765492")\("556d13a7f4d9cdfc03e439455daa0066c68785a3")\("6298465264107ae67e9e00c642dcad8a")"
        let MD5 = digest.hashed(.md5)
        XCTAssert(MD5 == "d206f79616d40f95f6e8e035eaa0f7c5", "Error getting the MD5 value")
    }
    
}
