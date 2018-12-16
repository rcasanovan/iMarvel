//
//  CharactersRequest.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

struct CharactersRequest: RequestProtocol {
    
    typealias ResponseType = CharactersResponse
    var completion: ((Result<CharactersResponse?>) -> Void)?
    var method: HTTPMethod = .get
    var url: URL? = nil
    var encodableBody: Encodable?
    var simulatedResponseJSONFile: String?
    var verbose: Bool?
    var contentType: ContentType = .json
    var processHeader: Bool? = false
    
    init(limit: UInt, offset: UInt) {
        url = Endpoint.getCharactersWith(limit: limit, offset: offset).url
    }
    
}
