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
    
    private var allSeriesSync: Bool = false
    private var serieListViewModel: [ComicViewModel]
    private var seriesLimit: UInt
    private var seriesOffSet: UInt
    
    private var allStoriesSync: Bool = false
    private var storyListViewModel: [ComicViewModel]
    private var storiesLimit: UInt
    private var storiesOffSet: UInt
    
    private var allEventsSync: Bool = false
    private var eventListViewModel: [ComicViewModel]
    private var eventsLimit: UInt
    private var eventsOffSet: UInt
    
    private var sectionSelected: OptionType
    
    private var copyright: String?
    
    init(characterDetail: CharactersListViewModel) {
        self.characterDetail = characterDetail
        comicListViewModel = []
        comicsOffSet = 0
        comicsLimit = 100
        
        serieListViewModel = []
        seriesOffSet = 0
        seriesLimit = 100
        
        storyListViewModel = []
        storiesOffSet = 0
        storiesLimit = 100
        
        eventListViewModel = []
        eventsOffSet = 0
        eventsLimit = 100
        
        sectionSelected = .comics
    }
    
}

extension CharacterDetailInteractor {
    
    func getComicsResultsWith(characterId: Int32, limit: UInt, offset: UInt, simulatedJSONFile: String? = nil, type: CharacterRequestType, completion: @escaping getComicsCompletionBlock) {
        var comicsRequest = ComicsRequest(characterId: characterId, limit: limit, offset: offset, type: type)
        
        comicsRequest.completion = completion
        comicsRequest.simulatedResponseJSONFile = simulatedJSONFile
        requestManager.send(request: comicsRequest)
    }
    
}

extension CharacterDetailInteractor: CharacterDetailInteractorDelegate {    
    
    func getCopyright() -> String? {
        return copyright
    }
    
    func setSectionSelected(_ type: OptionType) {
        sectionSelected = type
    }
    
    func getSectionSelected() -> OptionType {
        return sectionSelected
    }
    
    func getComicSelectedAt(_ index: Int) -> ComicViewModel? {
        switch sectionSelected {
        case .comics:
            if !comicListViewModel.indices.contains(index) { return nil }
            return comicListViewModel[index]
        case .series:
            if !serieListViewModel.indices.contains(index) { return nil }
            return serieListViewModel[index]
        case .stories:
            if !storyListViewModel.indices.contains(index) { return nil }
            return storyListViewModel[index]
        case .events:
            if !eventListViewModel.indices.contains(index) { return nil }
            return eventListViewModel[index]
        }
    }
    
    func getCharacter() -> CharactersListViewModel {
        return characterDetail
    }
    
    func getComicsWith(characterId: Int32, completion: @escaping CharacterDetailGetComicsCompletionBlock) {
        if allComicsSync {
            completion(comicListViewModel, nil, true, nil, allComicsSync)
            return
        }
        
        getComicsResultsWith(characterId: characterId, limit: comicsLimit, offset: comicsOffSet, type: .comics) { [weak self] (response) in
            guard let `self` = self else { return }
            
            switch response {
            case .success(let response):
                guard let response = response else {
                    completion(nil, nil, false, nil, self.allComicsSync)
                    return
                }
                
                if response.data.limit > response.data.count {
                    self.allComicsSync = true
                }
                
                self.comicsOffSet = self.comicsOffSet + self.comicsLimit
                
                let responseViewModel = ComicViewModel.getViewModelsWith(comics: response.data.results)
                self.comicListViewModel.append(contentsOf: responseViewModel)
                self.copyright = response.attributionText
                completion(self.comicListViewModel, response.attributionText, true, nil, self.allComicsSync)
            case .failure(let error):
                completion(nil, nil,  false, error, self.allComicsSync)
            }
        }
    }
    
    func getSeriesWith(characterId: Int32, completion: @escaping CharacterDetailGetComicsCompletionBlock) {
        if allSeriesSync {
            completion(comicListViewModel, nil, true, nil, allComicsSync)
            return
        }
        
        getComicsResultsWith(characterId: characterId, limit: seriesLimit, offset: seriesOffSet, type: .series) { [weak self] (response) in
            guard let `self` = self else { return }
            
            switch response {
            case .success(let response):
                guard let response = response else {
                    completion(nil, nil, false, nil, self.allSeriesSync)
                    return
                }
                
                if response.data.limit > response.data.count {
                    self.allSeriesSync = true
                }
                
                self.seriesOffSet = self.seriesOffSet + self.seriesLimit
                
                let responseViewModel = ComicViewModel.getViewModelsWith(comics: response.data.results)
                self.serieListViewModel.append(contentsOf: responseViewModel)
                self.copyright = response.attributionText
                completion(self.serieListViewModel, response.attributionText, true, nil, self.allSeriesSync)
            case .failure(let error):
                completion(nil, nil,  false, error, self.allSeriesSync)
            }
        }
    }
    
    func getStoriesWith(characterId: Int32, completion: @escaping CharacterDetailGetComicsCompletionBlock) {
        if allStoriesSync {
            completion(storyListViewModel, nil, true, nil, allStoriesSync)
            return
        }
        
        getComicsResultsWith(characterId: characterId, limit: storiesLimit, offset: storiesOffSet, type: .stories) { [weak self] (response) in
            guard let `self` = self else { return }
            
            switch response {
            case .success(let response):
                guard let response = response else {
                    completion(nil, nil, false, nil, self.allStoriesSync)
                    return
                }
                
                if response.data.limit > response.data.count {
                    self.allStoriesSync = true
                }
                
                self.storiesOffSet = self.storiesOffSet + self.storiesLimit
                
                let responseViewModel = ComicViewModel.getViewModelsWith(comics: response.data.results)
                self.storyListViewModel.append(contentsOf: responseViewModel)
                self.copyright = response.attributionText
                completion(self.storyListViewModel, response.attributionText, true, nil, self.allStoriesSync)
            case .failure(let error):
                completion(nil, nil,  false, error, self.allStoriesSync)
            }
        }
    }
    
    func getEventsWith(characterId: Int32, completion: @escaping CharacterDetailGetComicsCompletionBlock) {
        if allEventsSync {
            completion(eventListViewModel, nil, true, nil, allEventsSync)
            return
        }
        
        getComicsResultsWith(characterId: characterId, limit: eventsLimit, offset: eventsOffSet, type: .events) { [weak self] (response) in
            guard let `self` = self else { return }
            
            switch response {
            case .success(let response):
                guard let response = response else {
                    completion(nil, nil, false, nil, self.allEventsSync)
                    return
                }
                
                if response.data.limit > response.data.count {
                    self.allEventsSync = true
                }
                
                self.eventsOffSet = self.eventsOffSet + self.eventsLimit
                
                let responseViewModel = ComicViewModel.getViewModelsWith(comics: response.data.results)
                self.eventListViewModel.append(contentsOf: responseViewModel)
                self.copyright = response.attributionText
                completion(self.eventListViewModel, response.attributionText, true, nil, self.allEventsSync)
            case .failure(let error):
                completion(nil, nil,  false, error, self.allEventsSync)
            }
        }
    }
    
    func getSyncComics() -> [ComicViewModel] {
        return comicListViewModel
    }
    
    func getSyncSeries() -> [ComicViewModel] {
        return serieListViewModel
    }
    
    func getSyncStories() -> [ComicViewModel] {
        return storyListViewModel
    }
    
    func getSyncEvents() -> [ComicViewModel] {
        return eventListViewModel
    }
    
    func shouldGetComics() -> Bool {
        return !allComicsSync
    }
    
    func shouldGetSeries() -> Bool {
        return !allSeriesSync
    }
    
    func shouldGetStories() -> Bool {
        return !allStoriesSync
    }
    
    func shouldGetEvents() -> Bool {
        return !allEventsSync
    }
    
}
