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
    func loadComics(_ viewModels: [ComicViewModel], copyright: String?, fromBeginning: Bool)
    func showMessageWith(title: String, message: String, actionTitle: String)
}

protocol CharacterDetailPresenterDelegate : class {
    func viewDidLoad()
    func optionSelected(_ option: OptionType)
}

// Presenter / Interactor
typealias CharacterDetailGetComicsCompletionBlock = (_ viewModel: [ComicViewModel]?, _ copyright: String?, _ success: Bool, _ error: ResultError?, _ allCharactersSync: Bool) -> Void

protocol CharacterDetailInteractorDelegate : class {
    func getCharacter() -> CharactersListViewModel
    func getComicsWith(characterId: Int32, completion: @escaping CharacterDetailGetComicsCompletionBlock)
    func getSyncComics() -> [ComicViewModel]
    func shouldGetComics() -> Bool
}

// Presenter / Router
protocol CharacterDetailRouterDelegate : class {
}
