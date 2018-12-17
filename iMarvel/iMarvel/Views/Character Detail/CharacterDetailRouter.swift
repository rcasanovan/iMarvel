//
//  CharacterDetailRouter.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

class CharacterDetailRouter {
    
    public static func setupModule(navigationController: UINavigationController? = nil) -> UIViewController {
        let characterDetailVC = CharacterDetailViewController()
        return characterDetailVC
    }
    
}
