//
//  SuggestionsTest.swift
//  iMarvelTests
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import XCTest
@testable import iMarvel

class SuggestionsTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDeleteAllSuggestions() {
        SearchSuggestionsManager.saveSuggestion("Iron man")
        SearchSuggestionsManager.saveSuggestion("Hulk")
        SearchSuggestionsManager.saveSuggestion("Wolverine")
        SearchSuggestionsManager.deleteAllSuggestions()
        
        let suggestions = SearchSuggestionsManager.getSuggestions()
        XCTAssert(suggestions.count == 0)
    }
    
    func testSaveSuggestions() {
        SearchSuggestionsManager.deleteAllSuggestions()
        
        SearchSuggestionsManager.saveSuggestion("Iron man")
        SearchSuggestionsManager.saveSuggestion("Hulk")
        SearchSuggestionsManager.saveSuggestion("Wolverine")
        
        let suggestions = SearchSuggestionsManager.getSuggestions()
        XCTAssert(suggestions.count == 3)
    }
    
    func testOrderSuggestions() {
        SearchSuggestionsManager.deleteAllSuggestions()
        
        SearchSuggestionsManager.saveSuggestion("Iron man")
        SearchSuggestionsManager.saveSuggestion("Hulk")
        SearchSuggestionsManager.saveSuggestion("Wolverine")
        
        let suggestions = SearchSuggestionsManager.getSuggestions()
        XCTAssert(suggestions[0].suggestion == "wolverine" &&
            suggestions[1].suggestion == "hulk" &&
            suggestions[2].suggestion == "iron man")
    }
    
    func testOnlyMaintainFirstSuggestions() {
        SearchSuggestionsManager.deleteAllSuggestions()
        
        SearchSuggestionsManager.saveSuggestion("Iron man")
        SearchSuggestionsManager.saveSuggestion("Hulk")
        SearchSuggestionsManager.saveSuggestion("Wolverine")
        SearchSuggestionsManager.saveSuggestion("Spider-man")
        SearchSuggestionsManager.saveSuggestion("Daredevil")
        SearchSuggestionsManager.saveSuggestion("Tony")
        SearchSuggestionsManager.saveSuggestion("Guardians")
        SearchSuggestionsManager.saveSuggestion("Professor")
        SearchSuggestionsManager.saveSuggestion("Stark")
        SearchSuggestionsManager.saveSuggestion("Matt Murdock")
        
        SearchSuggestionsManager.saveSuggestion("Iron man")
        
        let suggestions = SearchSuggestionsManager.getSuggestions()
        XCTAssert(suggestions.count == 10, "Max number of suggestions should be 10")
    }
    
    func testMovieExists() {
        SearchSuggestionsManager.deleteAllSuggestions()
        
        SearchSuggestionsManager.saveSuggestion("Iron man")
        SearchSuggestionsManager.saveSuggestion("Hulk")
        SearchSuggestionsManager.saveSuggestion("Wolverine")
        SearchSuggestionsManager.saveSuggestion("Spider-man")
        SearchSuggestionsManager.saveSuggestion("Daredevil")
        
        let suggestionExists = SearchSuggestionsManager.suggestionExists("Daredevil")
        XCTAssert(suggestionExists == true, "The suggestion doesn't exist in the data base")
    }

}
