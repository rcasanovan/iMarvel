//
//  ComicsRequest.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

enum CharacterRequestType {
    case comics
    case series
    case stories
    case events
}

struct ComicsRequest: RequestProtocol {
    
    typealias ResponseType = ComicsResponse
    var completion: ((Result<ComicsResponse?>) -> Void)?
    var method: HTTPMethod = .get
    var url: URL? = nil
    var encodableBody: Encodable?
    var simulatedResponseJSONFile: String?
    var verbose: Bool?
    var contentType: ContentType = .json
    var processHeader: Bool? = false
    
    init(characterId: Int32, limit: UInt, offset: UInt, type: CharacterRequestType) {
        switch type {
        case .comics:
            url = Endpoint.getComicsWith(characterId: characterId, limit: limit, offset: offset).url
        case .series:
            url = Endpoint.getSeriesWith(characterId: characterId, limit: limit, offset: offset).url
        case .stories:
            url = Endpoint.getStoriesWith(characterId: characterId, limit: limit, offset: offset).url
        case .events:
            url = Endpoint.getEventsWith(characterId: characterId, limit: limit, offset: offset).url
        }
        
    }
    
}
