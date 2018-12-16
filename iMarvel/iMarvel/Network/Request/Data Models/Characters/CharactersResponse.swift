//
//  CharactersResponse.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

public struct CharactersResponse: Decodable {
    
    let data: DataResponse
    
}

public struct DataResponse: Decodable {
    
    let offset: UInt
    let limit: UInt
    let total: Int8
    let count: Int8
    
}
