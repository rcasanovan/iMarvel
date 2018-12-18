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
}

protocol CharacterDetailPresenterDelegate : class {
    func viewDidLoad()
}

// Presenter / Interactor
protocol CharacterDetailInteractorDelegate : class {
    func getCharacter() -> CharactersListViewModel
}

// Presenter / Router
protocol CharacterDetailRouterDelegate : class {
}
