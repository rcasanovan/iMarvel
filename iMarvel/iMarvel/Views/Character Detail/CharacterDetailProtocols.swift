//
//  CharacterDetailProtocols.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

enum OptionType {
    case comics
    case series
    case stories
    case events
}

// View / Presenter
protocol CharacterDetailViewInjection : class {
    func showProgress(_ show: Bool, status: String)
    func showProgress(_ show: Bool)
    func loadCharacter(_ characterDetail: CharactersListViewModel)
    func loadComics(_ viewModels: [ComicViewModel], copyright: String?, fromBeginning: Bool, allComicsLoaded: Bool)
    func showMessageWith(title: String, message: String, actionTitle: String)
}

protocol CharacterDetailPresenterDelegate : class {
    func viewDidLoad()
    func optionSelected(_ option: OptionType)
    func comicSelectedAt(_ index: Int)
    func loadNextPage()
}

// Presenter / Interactor
typealias CharacterDetailGetComicsCompletionBlock = (_ viewModel: [ComicViewModel]?, _ copyright: String?, _ success: Bool, _ error: ResultError?, _ allCharactersSync: Bool) -> Void

protocol CharacterDetailInteractorDelegate : class {
    func getCopyright() -> String?
    
    func setSectionSelected(_ type: OptionType)
    func getSectionSelected() -> OptionType
    func getComicSelectedAt(_ index: Int) -> ComicViewModel?
    
    func getCharacter() -> CharactersListViewModel
    
    func getComicsWith(characterId: Int32, completion: @escaping CharacterDetailGetComicsCompletionBlock)
    func getSyncComics() -> [ComicViewModel]
    func shouldGetComics() -> Bool
    
    func getSeriesWith(characterId: Int32, completion: @escaping CharacterDetailGetComicsCompletionBlock)
    func getSyncSeries() -> [ComicViewModel]
    func shouldGetSeries() -> Bool
    
    func getStoriesWith(characterId: Int32, completion: @escaping CharacterDetailGetComicsCompletionBlock)
    func getSyncStories() -> [ComicViewModel]
    func shouldGetStories() -> Bool
    
    func getEventsWith(characterId: Int32, completion: @escaping CharacterDetailGetComicsCompletionBlock)
    func getSyncEvents() -> [ComicViewModel]
    func shouldGetEvents() -> Bool
}

// Presenter / Router
protocol CharacterDetailRouterDelegate : class {
    func showComicDetailWithUrl(_ url: URL)
}
