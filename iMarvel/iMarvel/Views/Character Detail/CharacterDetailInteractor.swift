//
//  CharacterDetailInteractor.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

class CharacterDetailInteractor {
    
    private let characterDetail: CharactersListViewModel
    
    init(characterDetail: CharactersListViewModel) {
        self.characterDetail = characterDetail
    }
    
}

extension CharacterDetailInteractor: CharacterDetailInteractorDelegate {
    
}
