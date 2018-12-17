//
//  CharactersListRouter.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class CharactersListRouter {
    
    public static func setupModule(navigationController: UINavigationController? = nil) -> UINavigationController {
        let charactersListVC = CharactersListViewController()
        charactersListVC.presenter = CharactersListPresenter(view: charactersListVC, navigationController: navigationController)
        
        let charactersListNVC = UINavigationController(rootViewController: charactersListVC)
        return charactersListNVC
    }
    
}
