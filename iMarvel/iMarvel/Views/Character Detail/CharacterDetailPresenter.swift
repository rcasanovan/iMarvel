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
                self.processComicsResults(comics: comics, copyright: copyright, showProgress: showProgress, allComicsLoaded: allComicsSync)
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
    
    private func getSeries(showProgress: Bool) {
        // Couldn't we have characters? -> return
        if !interactor.shouldGetSeries() { return }
        
        view?.showProgress(showProgress, status: "Loading series")
        
        let character = interactor.getCharacter()
        
        interactor.getSeriesWith(characterId: character.id) { [weak self] (comics, copyright, success, error, allComicsSync) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            
            if let comics = comics {
                self.processComicsResults(comics: comics, copyright: copyright, showProgress: showProgress, allComicsLoaded: allComicsSync)
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
    
    private func getStories(showProgress: Bool) {
        // Couldn't we have characters? -> return
        if !interactor.shouldGetStories() { return }
        
        view?.showProgress(showProgress, status: "Loading stories")
        
        let character = interactor.getCharacter()
        
        interactor.getStoriesWith(characterId: character.id) { [weak self] (comics, copyright, success, error, allComicsSync) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            
            if let comics = comics {
                self.processComicsResults(comics: comics, copyright: copyright, showProgress: showProgress, allComicsLoaded: allComicsSync)
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
    
    private func getEvents(showProgress: Bool) {
        // Couldn't we have characters? -> return
        if !interactor.shouldGetEvents() { return }
        
        view?.showProgress(showProgress, status: "Loading events")
        
        let character = interactor.getCharacter()
        
        interactor.getEventsWith(characterId: character.id) { [weak self] (comics, copyright, success, error, allComicsSync) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            
            if let comics = comics {
                self.processComicsResults(comics: comics, copyright: copyright, showProgress: showProgress, allComicsLoaded: allComicsSync)
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
    
    private func processComicsResults(comics: [ComicViewModel], copyright: String?, showProgress: Bool, allComicsLoaded: Bool) {
        
        view?.loadComics(comics, copyright: copyright, fromBeginning: showProgress, allComicsLoaded: allComicsLoaded)
    }
    
}

extension CharacterDetailPresenter: CharacterDetailPresenterDelegate {
    
    func viewDidLoad() {
        interactor.setSectionSelected(.comics)
        let character = interactor.getCharacter()
        view?.loadCharacter(character)
        getComics(showProgress: true)
    }
    
    func optionSelected(_ option: OptionType) {
        view?.loadComics([ComicViewModel](), copyright: interactor.getCopyright(), fromBeginning: true, allComicsLoaded: true)
        
        switch option {
        case .comics:
            interactor.setSectionSelected(.comics)
            let syncComics = interactor.getSyncComics()
            if syncComics.isEmpty {
                getComics(showProgress: true)
                return
            }
            view?.loadComics(syncComics, copyright: interactor.getCopyright(), fromBeginning: true, allComicsLoaded: true)
        case .series:
            interactor.setSectionSelected(.series)
            let syncSeries = interactor.getSyncSeries()
            if syncSeries.isEmpty {
                getSeries(showProgress: true)
                return
            }
            view?.loadComics(syncSeries, copyright: interactor.getCopyright(), fromBeginning: true, allComicsLoaded: true)
        case .stories:
            interactor.setSectionSelected(.stories)
            let syncStories = interactor.getSyncStories()
            if syncStories.isEmpty {
                getStories(showProgress: true)
                return
            }
            view?.loadComics(syncStories, copyright: interactor.getCopyright(), fromBeginning: true, allComicsLoaded: true)
        case .events:
            interactor.setSectionSelected(.events)
            let syncEvents = interactor.getSyncEvents()
            if syncEvents.isEmpty {
                getEvents(showProgress: true)
                return
            }
            view?.loadComics(syncEvents, copyright: interactor.getCopyright(), fromBeginning: true, allComicsLoaded: true)
        }
    }
    
    func comicSelectedAt(_ index: Int) {
        guard let comicSelected = interactor.getComicSelectedAt(index), let url = comicSelected.urlDetail else {
            return
        }
        
        router.showComicDetailWithUrl(url)
    }
    
    func loadNextPage() {
        let type = interactor.getSectionSelected()
        
        switch type {
        case .comics:
            getComics(showProgress: false)
        case .events:
            getEvents(showProgress: false)
        case .series:
            getSeries(showProgress: false)
        case .stories:
            getSeries(showProgress: false)
        }
    }
    
}
