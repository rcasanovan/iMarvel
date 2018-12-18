//
//  ComicViewModel.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

struct ComicViewModel {
    
    let id: Int32
    let title: String
    let description: String
    let urlImage: URL?
    
    init(id: Int32, title: String, description: String, urlImage: URL?) {
        self.id = id
        self.title = title
        self.description = description
        self.urlImage = urlImage
    }
    
    public static func getViewModelsWith(comics: [ComicResponse]) -> [ComicViewModel] {
        return comics.map { getViewModelWith(comic: $0) }
    }
    
    public static func getViewModelWith(comic: ComicResponse) -> ComicViewModel {
        let urlImage = ImageManager.shared.getPortraitUrlWith(comic.thumbnail.path, ext: comic.thumbnail.ext)
        
        return ComicViewModel(id: comic.id, title: comic.title, description: comic.description, urlImage: urlImage)
    }
    
}
