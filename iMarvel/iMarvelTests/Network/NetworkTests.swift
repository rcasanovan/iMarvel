//
//  NetworkTests.swift
//  iMarvelTests
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import XCTest
@testable import iMarvel

typealias charactersCompletionBlock = (Result<CharactersResponse?>) -> Void

class NetworkTests: XCTestCase {

    private let requestManager = RequestManager()
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCharactersResultsWith(nameStartsWith: String? = nil, limit: UInt, offset: UInt, simulatedJSONFile: String? = nil,  completion: @escaping charactersCompletionBlock) {
        var charactersRequest = CharactersRequest(nameStartsWith: nameStartsWith, limit: limit, offset: offset)
        
        charactersRequest.completion = completion
        charactersRequest.simulatedResponseJSONFile = simulatedJSONFile
        charactersRequest.verbose = true
        requestManager.send(request: charactersRequest)
    }
    
    func testCharactersResults() {
        let charactersResultsExpectation: XCTestExpectation = self.expectation(description: "charactersResultsExpectation")
        
        testCharactersResultsWith(limit: 10, offset: 0){ (response) in
            switch response {
            case .success(let sessionResponse):
                guard let sessionResponse = sessionResponse else {
                    XCTFail("Impossible to get the session response")
                    return
                }
                XCTAssert(sessionResponse.data.count != 0, "data array can't be empty")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }

            charactersResultsExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }
    
    func testSimulatedCharactersResults() {
        let charactersResultsExpectation: XCTestExpectation = self.expectation(description: "charactersResultsExpectation")
        
        testCharactersResultsWith(limit: 10, offset: 0, simulatedJSONFile: "AllCharacters"){ (response) in
            switch response {
            case .success(let response):
                guard let response = response else {
                    XCTFail("Impossible to get the session response")
                    return
                }
                XCTAssert(response.data.count != 0, "data array can't be empty")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            
            charactersResultsExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }

}
