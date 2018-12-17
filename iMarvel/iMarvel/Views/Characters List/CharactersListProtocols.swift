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
}

protocol CharactersListPresenterDelegate : class {
    func searchCharacter(_ character: String)
    func loadNextPage()
    func getSuggestions()
    func suggestionSelectedAt(index: Int)
}

// Presenter / Interactor
typealias GetCharactersListCompletionBlock = (_ viewModel: [CharactersListViewModel]?, _ success: Bool, _ error: ResultError?, _ allCharactersSync: Bool) -> Void
typealias GetSuggestionsCompletionBlock = ([SuggestionViewModel]) -> Void

protocol CharactersListInteractorDelegate : class {
    func shouldGetCharacters() -> Bool
    func clearSearch()
    func getCharactersWith(character: String?, completion: @escaping GetCharactersListCompletionBlock)
    func saveSearch(_ search: String)
    func getAllSuggestions(completion: @escaping GetSuggestionsCompletionBlock)
}

// Presenter / Router
protocol CharactersListRouterDelegate : class {
}
