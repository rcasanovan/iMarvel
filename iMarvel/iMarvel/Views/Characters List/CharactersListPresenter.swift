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
    
    private func getCharacters(character: String? = nil, showProgress: Bool) {
        view?.showProgress(showProgress, status: "Loading characters")
        
        interactor.getCharactersWith(character: character) { [weak self] (characters, total, copyright, success, error, allCharactersSync) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            
            if let characters = characters, allCharactersSync == false {
                self.processCharactersResults(characterSearch: character, characters: characters, total: total, copyright: copyright, showProgress: showProgress)
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
    
    private func processCharactersResults(characterSearch: String?, characters: [CharactersListViewModel], total: Int, copyright: String?, showProgress: Bool) {
        
        if !characters.isEmpty {
            if let characterSearch = characterSearch {
                // Save the character search
                interactor.saveSearch(characterSearch)
            }
        }
        else {
            view?.showMessageWith(title: "Oops", message: "It seems we don't have that character in the catalog right now 😢. Please try again", actionTitle: "Accept")
        }
        
        view?.loadCharacters(characters, totalResults: total, copyright: copyright)
    }
    
}

extension CharactersListPresenter: CharactersListPresenterDelegate {
    
    func viewDidLoad() {
        getCharacters(showProgress: true)
    }
    
    func searchCharacter(_ character: String) {
        interactor.clearSearch()
        getCharacters(character: character, showProgress: true)
    }
    
    func loadNextPage() {
    }
    
    func getSuggestions() {
        interactor.getAllSuggestions { [weak self] (suggestions) in
            guard let `self` = self else { return }
            self.view?.loadSuggestions(suggestions)
        }
    }
    
    func suggestionSelectedAt(index: Int) {
    }
    
}
