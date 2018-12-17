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
    
    init() {
        charactersListViewModel = []
    }
    
}

extension CharactersListInteractor {
    
    private func getCharactersResultsWith(limit: UInt, offset: UInt, simulatedJSONFile: String? = nil,  completion: @escaping getCharactersCompletionBlock) {
        var charactersRequest = CharactersRequest(limit: limit, offset: offset)
        
        charactersRequest.completion = completion
        charactersRequest.simulatedResponseJSONFile = simulatedJSONFile
        requestManager.send(request: charactersRequest)
    }
    
}

extension CharactersListInteractor: CharactersListInteractorDelegate {
    
    func shouldGetCharacters() -> Bool {
        return true
    }
    
    func clearSearch() {
    }
    
    func getCharactersWith(character: String?, completion: @escaping CharactersListGetCharactersCompletionBlock) {
        if allCharactersSync {
            completion(charactersListViewModel, 0, true, nil, allCharactersSync)
            return
        }
        
        getCharactersResultsWith(limit: 10, offset: 0){ [weak self] (response) in
            guard let `self` = self else { return }
            
            switch response {
            case .success(let response):
                guard let response = response else {
                    completion(nil, 0, false, nil, self.allCharactersSync)
                    return
                }
                
                let responseViewModel = CharactersListViewModel.getViewModelsWith(characters: response.data.results)
                self.charactersListViewModel.append(contentsOf: responseViewModel)
                completion(self.charactersListViewModel, response.data.total, true, nil, self.allCharactersSync)
            case .failure(let error):
                completion(nil, 0, false, error, self.allCharactersSync)
            }
        }
    }
    
    func saveSearch(_ search: String) {
    }
    
    func getAllSuggestions(completion: @escaping CharactersListGetSuggestionsCompletionBlock) {
    }
    
}
