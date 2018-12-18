//
//  ComicsResponse.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

public struct ComicsResponse: Decodable {
    
    let copyright: String
    let attributionText: String
    let data: ComicDataResponse
    
}

public struct ComicDataResponse: Decodable {
    
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [ComicResponse]
    
}

public struct ComicResponse: Decodable {
    
    let id: Int32
    let tile: String
    let description: String
    let thumbnail: ThumbnailResponse
    
}
