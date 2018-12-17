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
typealias CharactersListGetCharactersCompletionBlock = (_ viewModel: [CharactersListViewModel]?, _ success: Bool, _ error: ResultError?, _ allCharactersSync: Bool) -> Void
typealias CharactersListGetSuggestionsCompletionBlock = ([SuggestionViewModel]) -> Void

protocol CharactersListInteractorDelegate : class {
    func shouldGetCharacters() -> Bool
    func clearSearch()
    func getCharactersWith(character: String?, completion: @escaping CharactersListGetCharactersCompletionBlock)
    func saveSearch(_ search: String)
    func getAllSuggestions(completion: @escaping CharactersListGetSuggestionsCompletionBlock)
}

// Presenter / Router
protocol CharactersListRouterDelegate : class {
}
