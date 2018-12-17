//
//  SuggestionViewModel.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

struct SuggestionViewModel {
    
    let suggestion: String
    
    init(suggestion: String) {
        self.suggestion = suggestion
    }
    
    /**
     * Get the view models with a IMSearchSuggestion array
     */
    public static func getViewModelsWith(suggestions: [SearchSuggestion]) -> [SuggestionViewModel] {
        return suggestions.map { getViewModelWith(suggestion: $0) }
    }
    
    /**
     * Get a single view model with a IMSearchSuggestion
     */
    public static func getViewModelWith(suggestion: SearchSuggestion) -> SuggestionViewModel {
        return SuggestionViewModel.init(suggestion: suggestion.suggestion)
    }
    
}
