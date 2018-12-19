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
    private let router: CharactersListRouterDelegate
    
    // MARK - Lifecycle
    init(view: CharactersListViewInjection, navigationController: UINavigationController? = nil) {
        self.view = view
        self.interactor = CharactersListInteractor()
        self.router = CharactersListRouter(navigationController: navigationController)
    }
    
}

extension CharactersListPresenter {
    
    private func getCharacters(showProgress: Bool) {
        // Couldn't we have characters? -> return
        if !interactor.shouldGetCharacters() { return }
        
        let currentSearchCharacter = interactor.getCurrentSearchCharacter()
        
        view?.showProgress(showProgress, status: "Loading characters")
        
        interactor.getCharactersWith(character: currentSearchCharacter) { [weak self] (characters, total, copyright, success, error, allCharactersSync) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            
            if let characters = characters {
                self.processCharactersResults(characterSearch: currentSearchCharacter, characters: characters, total: total, copyright: copyright, showProgress: showProgress, allCharactersLoaded: allCharactersSync)
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
    
    private func processCharactersResults(characterSearch: String?, characters: [CharactersListViewModel], total: Int, copyright: String?, showProgress: Bool, allCharactersLoaded: Bool) {
        
        if !characters.isEmpty {
            if let characterSearch = characterSearch {
                // Save the character search
                interactor.saveSearch(characterSearch)
            }
        }
        else {
            view?.showMessageWith(title: "Oops", message: "It seems we don't have that character in the catalog right now 😢. Please try again", actionTitle: "Accept")
        }
        
        view?.loadCharacters(characters, totalResults: total, copyright: copyright, fromBeginning: showProgress, allCharactersLoaded: allCharactersLoaded)
    }
    
}

extension CharactersListPresenter: CharactersListPresenterDelegate {
    
    func viewDidLoad() {
        getCharacters(showProgress: true)
    }
    
    func searchCharacter(_ character: String) {
        // If the character is completely empty or only contains whitespaces -> show an error message
        if character.isEmptyOrWhitespace() {
            view?.showMessageWith(title: "Oops ✋🤚", message: "It looks you´re trying to search a movie using a invalid criteria. Please try again", actionTitle: "Accept")
            return
        }
        
        interactor.clearSearch()
        interactor.updateSearchCharacter(character.condenseWhitespaces())
        getCharacters(showProgress: true)
    }
    
    func loadNextPage() {
        getCharacters(showProgress: false)
    }
    
    func getSuggestions() {
        interactor.getAllSuggestions { [weak self] (suggestions) in
            guard let `self` = self else { return }
            self.view?.loadSuggestions(suggestions)
        }
    }
    
    func suggestionSelectedAt(index: Int) {
        guard let suggestion = interactor.getSuggestionAt(index: index) else {
            return
        }
        searchCharacter(suggestion.suggestion)
    }
    
    func showCharacterDetailAt(index: Int) {
        guard let character = interactor.getCharacterAt(index: index) else {
            return
        }
        router.showDetail(character)
    }
    
    func refreshResults() {
        interactor.clearSearch()
        view?.loadCharacters([CharactersListViewModel](), totalResults: 0, copyright: "", fromBeginning: true, allCharactersLoaded: true)
        getCharacters(showProgress: true)
    }
    
}
