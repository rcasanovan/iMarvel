//
//  CharacterDetailProtocols.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

// View / Presenter
protocol CharacterDetailViewInjection : class {
    func loadCharacter(_ characterDetail: CharactersListViewModel)
    func loadCharacters(_ viewModels: [ComicViewModel], copyright: String?, fromBeginning: Bool)
}

protocol CharacterDetailPresenterDelegate : class {
    func viewDidLoad()
}

// Presenter / Interactor
typealias CharacterDetailGetComicsCompletionBlock = (_ viewModel: [ComicViewModel]?, _ total: Int, _ copyright: String?, _ success: Bool, _ error: ResultError?, _ allCharactersSync: Bool) -> Void

protocol CharacterDetailInteractorDelegate : class {
    func getCharacter() -> CharactersListViewModel
    func getComicsWith(characterId: String, completion: @escaping CharacterDetailGetComicsCompletionBlock)
}

// Presenter / Router
protocol CharacterDetailRouterDelegate : class {
}
