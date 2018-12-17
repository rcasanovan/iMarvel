//
//  CharactersResponse.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

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
    
}
