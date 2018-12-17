//
//  CharactersListPresenter.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class CharactersListPresenter {
    
    private weak var view: CharactersListViewInjection?
    private let interactor: CharactersListInteractorDelegate
    
    // MARK - Lifecycle
    init(view: CharactersListViewInjection, navigationController: UINavigationController? = nil) {
        self.view = view
        self.interactor = CharactersListInteractor()
    }
    
}

extension CharactersListPresenter: CharactersListPresenterDelegate {
    
}
