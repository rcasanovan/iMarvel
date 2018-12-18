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
    let modifiedDate: String?
    let comics: String
    let series: String
    let stories: String
    let events: String
    
    init(id: Int32, name: String, description: String, backgroundUrlImage: URL?, posterUrlImage: URL?, modifiedDate: String?, comics: String, series: String, stories: String, events: String) {
        self.id = id
        self.name = name
        self.description = description
        self.backgroundUrlImage = backgroundUrlImage
        self.posterUrlImage = posterUrlImage
        self.modifiedDate = modifiedDate
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
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
        
        let date = Date.getISODateWithString(character.modified)
        let stringDate = date?.getStringMMMddyyyyFormat()
        
        let comics = "\(character.comics.available)"
        let series = "\(character.series.available)"
        let stories = "\(character.stories.available)"
        let events = "\(character.events.available)"
        
        return CharactersListViewModel(id: character.id, name: character.name, description: character.description, backgroundUrlImage: backgroundUrlImage, posterUrlImage: posterUrlImage, modifiedDate: stringDate, comics: comics, series: series, stories: stories, events: events)
    }
    
}
