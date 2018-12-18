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
typealias comicsCompletionBlock = (Result<ComicsResponse?>) -> Void

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
    
    func testComicsResultsWith(characterId: Int32, limit: UInt, offset: UInt, simulatedJSONFile: String? = nil,  completion: @escaping comicsCompletionBlock) {
        var comicsRequest = ComicsRequest(characterId: characterId, limit: limit, offset: offset)
        
        comicsRequest.completion = completion
        comicsRequest.simulatedResponseJSONFile = simulatedJSONFile
        comicsRequest.verbose = true
        requestManager.send(request: comicsRequest)
    }
    
    func testCharactersResults() {
        let charactersResultsExpectation: XCTestExpectation = self.expectation(description: "charactersResultsExpectation")
        
        testCharactersResultsWith(limit: 10, offset: 0){ (response) in
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
    
    func testComicsResults() {
        let comicsResultsExpectation: XCTestExpectation = self.expectation(description: "comicsResultsExpectation")
        
        testComicsResultsWith(characterId: 1009144, limit: 10, offset: 0) { (response) in
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
            
            comicsResultsExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }
    
    func testSimulatedComicsResults() {
        let comicsResultsExpectation: XCTestExpectation = self.expectation(description: "comicsResultsExpectation")
        
        testComicsResultsWith(characterId: 1017100, limit: 10, offset: 0, simulatedJSONFile: "Comics") { (response) in
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
            
            comicsResultsExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 25.0, handler: nil)
    }

}
