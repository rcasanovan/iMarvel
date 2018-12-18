//
//  CharacterDetailPresenter.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

class CharacterDetailPresenter {
    
    private weak var view: CharacterDetailViewInjection?
    private let interactor: CharacterDetailInteractorDelegate
    private let router: CharacterDetailRouterDelegate
    
    // MARK - Lifecycle
    init(characterDetail: CharactersListViewModel, view: CharacterDetailViewInjection, navigationController: UINavigationController? = nil) {
        self.view = view
        self.interactor = CharacterDetailInteractor(characterDetail: characterDetail)
        self.router = CharacterDetailRouter(navigationController: navigationController)
    }
    
}

extension CharacterDetailPresenter: CharacterDetailPresenterDelegate {
    
}
