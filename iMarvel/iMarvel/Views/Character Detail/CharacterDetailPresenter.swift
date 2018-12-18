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

extension CharacterDetailPresenter {
    
    private func getComics(showProgress: Bool) {
        // Couldn't we have characters? -> return
        if !interactor.shouldGetComics() { return }
                
        view?.showProgress(showProgress, status: "Loading comics")
        
        let character = interactor.getCharacter()
        
        interactor.getComicsWith(characterId: character.id) { [weak self] (comics, copyright, success, error, allComicsSync) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            
            if let comics = comics {
                self.processComicsResults(comics: comics, copyright: copyright, showProgress: showProgress)
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
    
    private func processComicsResults(comics: [ComicViewModel], copyright: String?, showProgress: Bool) {
        
        view?.loadComics(comics, copyright: copyright, fromBeginning: showProgress)
    }
    
}

extension CharacterDetailPresenter: CharacterDetailPresenterDelegate {
    
    func viewDidLoad() {
        let character = interactor.getCharacter()
        view?.loadCharacter(character)
        getComics(showProgress: true)
    }
    
    func optionSelected(_ option: OptionType) {
        view?.loadComics([ComicViewModel](), copyright: nil, fromBeginning: true)
        
        switch option {
        case .comics:
            let syncComics = interactor.getSyncComics()
            if syncComics.isEmpty {
                getComics(showProgress: true)
                return
            }
            view?.loadComics(interactor.getSyncComics(), copyright: nil, fromBeginning: true)
        case .series:
            getComics(showProgress: true)
        case .stories:
            getComics(showProgress: true)
        case .events:
            getComics(showProgress: true)
        }
    }
    
}
