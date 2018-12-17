//
//  CharactersResponse.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

public struct CharactersResponse: Decodable {
    
    let copyright: String
    let attributionText: String
    let data: DataResponse
    
}

public struct DataResponse: Decodable {
    
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [CharacterResponse]
    
}

public struct CharacterResponse: Decodable {
    
    let id: Int32
    let name: String
    let description: String
    let modified: String
    let thumbnail: ThumbnailResponse
    
}

public struct ThumbnailResponse: Decodable {
    
    let path: String
//    let ext: String
//    
//    //__ This is little trick.
//    //__ The "thumbnail" field has another field inside called "extension"
//    //__ The problem is we can't process this field using Swift
//    //__ so we need to create an enum like a "bridge" to process the field
//    enum CodingKeys: String, CodingKey {
//        case ext = "extension"
//    }
    
}
