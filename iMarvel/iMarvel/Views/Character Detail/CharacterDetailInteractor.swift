//
//  CharacterDetailInteractor.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

typealias getComicsCompletionBlock = (Result<ComicsResponse?>) -> Void

class CharacterDetailInteractor {
    
    private let characterDetail: CharactersListViewModel
    private let requestManager = RequestManager()
    private var allComicsSync: Bool = false
    private var comicListViewModel: [ComicViewModel]
    private var comicsLimit: UInt
    private var comicsOffSet: UInt
    
    init(characterDetail: CharactersListViewModel) {
        self.characterDetail = characterDetail
        comicListViewModel = []
        comicsOffSet = 0
        comicsLimit = 100
    }
    
}

extension CharacterDetailInteractor {
    
    func getComicsResultsWith(characterId: String, limit: UInt, offset: UInt, simulatedJSONFile: String? = nil, completion: @escaping getComicsCompletionBlock) {
        var comicsRequest = ComicsRequest(characterId: characterId, limit: limit, offset: offset)
        
        comicsRequest.completion = completion
        comicsRequest.simulatedResponseJSONFile = simulatedJSONFile
        requestManager.send(request: comicsRequest)
    }
    
}

extension CharacterDetailInteractor: CharacterDetailInteractorDelegate {
    
    func getCharacter() -> CharactersListViewModel {
        return characterDetail
    }
    
    func getComicsWith(characterId: String, completion: @escaping CharacterDetailGetComicsCompletionBlock) {
        if allComicsSync {
            completion(comicListViewModel, 0, nil, true, nil, allComicsSync)
            return
        }
        
        getComicsResultsWith(characterId: characterId, limit: comicsLimit, offset: comicsOffSet) { [weak self] (response) in
            guard let `self` = self else { return }
            
            switch response {
            case .success(let response):
                guard let response = response else {
                    completion(nil, 0, nil, false, nil, self.allComicsSync)
                    return
                }
                
                if response.data.limit > response.data.count {
                    self.allComicsSync = true
                }
                
                self.comicsOffSet = self.comicsOffSet + self.comicsLimit
                
                let responseViewModel = ComicViewModel.getViewModelsWith(comics: response.data.results)
                self.comicListViewModel.append(contentsOf: responseViewModel)
                completion(self.comicListViewModel, response.data.total, response.attributionText, true, nil, self.allComicsSync)
            case .failure(let error):
                completion(nil, 0, nil,  false, error, self.allComicsSync)
            }
        }
    }
    
}
