//
//  CharactersListInteractor.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

class CharactersListInteractor {
}

extension CharactersListInteractor: CharactersListInteractorDelegate {
    
    func shouldGetCharacters() -> Bool {
        return true
    }
    
    func clearSearch() {
    }
    
    func getCharactersWith(character: String?, completion: @escaping GetCharactersListCompletionBlock) {
    }
    
    func saveSearch(_ search: String) {
    }
    
    func getAllSuggestions(completion: @escaping GetSuggestionsCompletionBlock) {
    }
    
}
