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

extension CharactersListPresenter {
    
    private func getCharacters(character: String? = nil) {
        interactor.getCharactersWith(character: character) { [weak self] (characters, total, copyright, success, error, allCharactersSync) in
            guard let `self` = self else { return }
            
            if let characters = characters, allCharactersSync == false {
                self.view?.loadCharacters(characters, totalResults: total, copyright: copyright)
                return
            }
            
            if let error = error {
                self.view?.showMessageWith(title: "Oops... 🧐", message: error.localizedDescription, actionTitle: "Accept")
                return
            }
            
            if !success {
                self.view?.showMessageWith(title: "Oops... 🧐", message: "Something wrong happened. Please try again", actionTitle: "Accept")
                return
            }
        }
    }
    
}

extension CharactersListPresenter: CharactersListPresenterDelegate {
    
    func viewDidLoad() {
        getCharacters()
    }
    
    func searchCharacter(_ character: String) {
    }
    
    func loadNextPage() {
    }
    
    func getSuggestions() {
    }
    
    func suggestionSelectedAt(index: Int) {
    }
    
}
