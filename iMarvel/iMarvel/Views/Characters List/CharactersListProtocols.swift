//
//  CharactersListProtocols.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

// View / Presenter
protocol CharactersListViewInjection : class {
    func showProgress(_ show: Bool, status: String)
    func showProgress(_ show: Bool)
    func loadCharacters(_ viewModels: [CharactersListViewModel], totalResults: Int, copyright: String?)
    func loadSuggestions(_ suggestions: [SuggestionViewModel])
    func showMessageWith(title: String, message: String, actionTitle: String)
}

protocol CharactersListPresenterDelegate : class {
    func viewDidLoad()
    func searchCharacter(_ character: String)
    func loadNextPage()
    func getSuggestions()
    func suggestionSelectedAt(index: Int)
}

// Presenter / Interactor
typealias CharactersListGetCharactersCompletionBlock = (_ viewModel: [CharactersListViewModel]?, _ total: Int, _ copyright: String?, _ success: Bool, _ error: ResultError?, _ allCharactersSync: Bool) -> Void
typealias CharactersListGetSuggestionsCompletionBlock = ([SuggestionViewModel]) -> Void

protocol CharactersListInteractorDelegate : class {
    func shouldGetCharacters() -> Bool
    func clearSearch()
    func getCharactersWith(character: String?, completion: @escaping CharactersListGetCharactersCompletionBlock)
    func saveSearch(_ search: String)
    func getAllSuggestions(completion: @escaping CharactersListGetSuggestionsCompletionBlock)
    func getSuggestionAt(index: Int) -> SuggestionViewModel?
}

// Presenter / Router
protocol CharactersListRouterDelegate : class {
}
