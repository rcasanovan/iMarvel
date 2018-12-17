//
//  CharactersListInteractor.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

typealias getCharactersCompletionBlock = (Result<CharactersResponse?>) -> Void

class CharactersListInteractor {
    
    private let requestManager = RequestManager()
    private var allCharactersSync: Bool = false
    private var charactersListViewModel: [CharactersListViewModel]
    private var suggestions: [SuggestionViewModel]
    private var limit: UInt
    private var offSet: UInt
    private var searchCharacter: String?
    
    init() {
        charactersListViewModel = []
        suggestions = []
        offSet = 0
        limit = 100
    }
    
}

extension CharactersListInteractor {
    
    private func getCharactersResultsWith(nameStartsWith: String?, limit: UInt, offset: UInt, simulatedJSONFile: String? = nil,  completion: @escaping getCharactersCompletionBlock) {
        var charactersRequest = CharactersRequest(nameStartsWith: nameStartsWith, limit: limit, offset: offset)
        
        charactersRequest.completion = completion
        charactersRequest.simulatedResponseJSONFile = simulatedJSONFile
        requestManager.send(request: charactersRequest)
    }
    
}

extension CharactersListInteractor: CharactersListInteractorDelegate {
    
    func shouldGetCharacters() -> Bool {
        return !allCharactersSync
    }
    
    func clearSearch() {
        charactersListViewModel = []
        offSet = 0
        allCharactersSync = false
        searchCharacter = nil
    }
    
    func getCharactersWith(character: String?, completion: @escaping CharactersListGetCharactersCompletionBlock) {
        
        searchCharacter = character
        
        if allCharactersSync {
            completion(charactersListViewModel, 0, nil, true, nil, allCharactersSync)
            return
        }
        
        getCharactersResultsWith(nameStartsWith: character, limit: limit, offset: offSet){ [weak self] (response) in
            guard let `self` = self else { return }
            
            switch response {
            case .success(let response):
                guard let response = response else {
                    completion(nil, 0, nil, false, nil, self.allCharactersSync)
                    return
                }
                
                if response.data.limit > response.data.count {
                    self.allCharactersSync = true
                }
                
                self.offSet = self.offSet + self.limit
                
                let responseViewModel = CharactersListViewModel.getViewModelsWith(characters: response.data.results)
                self.charactersListViewModel.append(contentsOf: responseViewModel)
                completion(self.charactersListViewModel, response.data.total, response.attributionText, true, nil, self.allCharactersSync)
            case .failure(let error):
                completion(nil, 0, nil,  false, error, self.allCharactersSync)
            }
        }
    }
    
    func saveSearch(_ search: String) {
        SearchSuggestionsManager.saveSuggestion(search)
    }
    
    func getAllSuggestions(completion: @escaping CharactersListGetSuggestionsCompletionBlock) {
        let allSuggestions = SearchSuggestionsManager.getSuggestions()
        suggestions = SuggestionViewModel.getViewModelsWith(suggestions: allSuggestions)
        completion(suggestions)
    }
    
    func getSuggestionAt(index: Int) -> SuggestionViewModel? {
        if !suggestions.indices.contains(index) { return nil }
        
        return suggestions[index]
    }
    
    func getCurrentSearchCharacter() -> String? {
        return searchCharacter
    }
    
    func updateSearchCharacter(_ searchCharacter: String) {
        self.searchCharacter = searchCharacter
    }
    
}
