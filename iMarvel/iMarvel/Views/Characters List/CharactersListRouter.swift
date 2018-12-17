//
//  CharactersListRouter.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class CharactersListRouter {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    public static func setupModule(navigationController: UINavigationController? = nil) -> UINavigationController {
        let charactersListVC = CharactersListViewController()
        let charactersListNVC = UINavigationController(rootViewController: charactersListVC)
        charactersListVC.presenter = CharactersListPresenter(view: charactersListVC, navigationController: charactersListNVC)
        return charactersListNVC
    }
    
}

extension CharactersListRouter: CharactersListRouterDelegate {
    
    func showDetail() {
        let detailVC = CharacterDetailRouter.setupModule(navigationController: navigationController)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
