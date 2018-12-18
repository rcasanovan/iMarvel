//
//  ComicsRequest.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

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
    
    init(characterId: String, limit: UInt, offset: UInt) {
        url = Endpoint.getComicWith(characterId: characterId, limit: limit, offset: offset).url
    }
    
}
