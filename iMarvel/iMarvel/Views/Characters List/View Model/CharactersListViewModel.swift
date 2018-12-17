//
//  CharactersListViewModel.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

struct CharactersListViewModel {
    
    let id: Int32
    let name: String
    let description: String
    let backgroundUrlImage: URL?
    let posterUrlImage: URL?
    
    init(id: Int32, name: String, description: String, backgroundUrlImage: URL?, posterUrlImage: URL?) {
        self.id = id
        self.name = name
        self.description = description
        self.backgroundUrlImage = backgroundUrlImage
        self.posterUrlImage = posterUrlImage
    }
    
    public static func getViewModelsWith(characters: [CharacterResponse]) -> [CharactersListViewModel] {
        return characters.map { getViewModelWith(character: $0) }
    }
    
    /**
     * Get a single view model with a IMSingleMovieResponse
     */
    public static func getViewModelWith(character: CharacterResponse) -> CharactersListViewModel {
        let backgroundUrlImage = ImageManager.shared.getLandscapeUrlWith(character.thumbnail.path, ext: character.thumbnail.ext)
        let posterUrlImage = ImageManager.shared.getPortraitUrlWith(character.thumbnail.path, ext: character.thumbnail.ext)
        
        return CharactersListViewModel(id: character.id, name: character.name, description: character.description, backgroundUrlImage: backgroundUrlImage, posterUrlImage: posterUrlImage)
    }
    
}
