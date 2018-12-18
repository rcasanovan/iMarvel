//
//  CharacterDetailRouter.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

class CharacterDetailRouter {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    public static func setupModule(character: CharactersListViewModel, navigationController: UINavigationController? = nil) -> CharacterDetailViewController {
        let characterDetailVC = CharacterDetailViewController()
        characterDetailVC.presenter = CharacterDetailPresenter(characterDetail: character, view: characterDetailVC, navigationController: navigationController)
        return characterDetailVC
    }
    
}

extension CharacterDetailRouter: CharacterDetailRouterDelegate {
    
}
