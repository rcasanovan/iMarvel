//
//  EndPoint.swift
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit

protocol EndpointProtocol: RawRepresentable where RawValue == String {
    static var baseUrl: String { get }
    var url: URL? { get }
}

/**
 * Internal struct for Url
 */
private struct Url {
    
    static let baseUrl: String = "https://gateway.marvel.com:443"
    static let apiKey: String = "6298465264107ae67e9e00c642dcad8a"
    
    struct Fields {
        static let apiKey: String = "apikey"
        static let limit: String = "limit"
        static let offset: String = "offset"
    }
    
}

// MARK: - Endpoints
enum Endpoint: EndpointProtocol {
    
    var rawValue: String {
        switch self {
        case .getCharactersWith(let limit, let offset):
            return "/v1/public/characters?\(Url.Fields.apiKey)=\(Url.apiKey)&\(Url.Fields.limit)=\(limit)&\(Url.Fields.offset)=\(offset)"
        }
    }
    
    case getCharactersWith(limit: UInt, offset: UInt)
}

extension EndpointProtocol {
    
    init?(rawValue: String) {
        assertionFailure("init(rawValue:) not implemented")
        return nil
    }
    
    var url: URL? {
        let urlComponents = URLComponents(string: Endpoint.baseUrl + self.rawValue)
        return urlComponents?.url
    }
    
    static var baseUrl: String {
        return "\(Url.baseUrl)"
    }
    
}
