//
//  ComicViewModel.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

enum UrlType: String {
    case detail = "detail"
    case purchase = "purchase"
    case reader = "reader"
    case inAppLink = "inAppLink"
}

struct ComicViewModel {
    
    let id: Int32
    let title: String
    let description: String?
    let urlImage: URL?
    let urlDetail: URL?
    
    init(id: Int32, title: String, description: String?, urlImage: URL?, urlDetail: URL?) {
        self.id = id
        self.title = title
        self.description = description
        self.urlImage = urlImage
        self.urlDetail = urlDetail
    }
    
    public static func getViewModelsWith(comics: [ComicResponse]) -> [ComicViewModel] {
        return comics.map { getViewModelWith(comic: $0) }
    }
    
    public static func getViewModelWith(comic: ComicResponse) -> ComicViewModel {
        let urlImage = ImageManager.shared.getPortraitUrlWith(comic.thumbnail?.path, ext: comic.thumbnail?.ext)
        
        let urlDetail = getUrlDetailForType(.detail, urls: comic.urls)
        
        return ComicViewModel(id: comic.id, title: comic.title, description: comic.description, urlImage: urlImage, urlDetail: urlDetail)
    }
    
}

extension ComicViewModel {
    
    private static func getUrlDetailForType(_ type: UrlType, urls: [UrlResponse]?) -> URL? {
        guard let urls = urls else {
            return nil
        }
        
        let urlsResponse = urls.filter { $0.type == type.rawValue }
        guard let urlResponse = urlsResponse.first else {
            return nil
        }
        
        return URL(string: urlResponse.url)
    }
    
}
