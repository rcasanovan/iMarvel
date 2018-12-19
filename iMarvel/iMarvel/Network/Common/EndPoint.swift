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
    static let privateKey: String = "556d13a7f4d9cdfc03e439455daa0066c68785a3"
    
    struct Fields {
        static let apiKey: String = "apikey"
        static let limit: String = "limit"
        static let offset: String = "offset"
        static let hash: String = "hash"
        static let ts: String = "ts"
        static let nameStartsWith: String = "nameStartsWith"
    }
    
}

// MARK: - Endpoints
enum Endpoint: EndpointProtocol {
    
    var rawValue: String {
        switch self {
        case .getCharactersWith(let nameStartsWith, let limit, let offset):
            let ts = String(format: "%f", Date().timeIntervalSince1970)
            guard let hash = "\(ts)\(Url.privateKey)\(Url.apiKey)".hashed(.md5) else {
                return "/v1/public/characters"
            }
            var endpoint = "/v1/public/characters?\(Url.Fields.apiKey)=\(Url.apiKey)&\(Url.Fields.limit)=\(limit)&\(Url.Fields.offset)=\(offset)&\(Url.Fields.ts)=\(ts)&\(Url.Fields.hash)=\(hash)"
            
            if let nameStartsWith = nameStartsWith, let nameStartsWithUrlFormat = nameStartsWith.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                endpoint = "\(endpoint)&\(Url.Fields.nameStartsWith)=\(nameStartsWithUrlFormat)"
            }
            
            return endpoint
            
        case .getComicsWith(let characterId, let limit, let offset):
            let ts = String(format: "%f", Date().timeIntervalSince1970)
            guard let hash = "\(ts)\(Url.privateKey)\(Url.apiKey)".hashed(.md5) else {
                return "/v1/public/characters/\(characterId)/comics"
            }
            let endpoint = "/v1/public/characters/\(characterId)/comics?\(Url.Fields.apiKey)=\(Url.apiKey)&\(Url.Fields.limit)=\(limit)&\(Url.Fields.offset)=\(offset)&\(Url.Fields.ts)=\(ts)&\(Url.Fields.hash)=\(hash)"
            
            return endpoint
        
        case .getSeriesWith(let characterId, let limit, let offset):
            let ts = String(format: "%f", Date().timeIntervalSince1970)
            guard let hash = "\(ts)\(Url.privateKey)\(Url.apiKey)".hashed(.md5) else {
                return "/v1/public/characters/\(characterId)/comics"
            }
            let endpoint = "/v1/public/characters/\(characterId)/series?\(Url.Fields.apiKey)=\(Url.apiKey)&\(Url.Fields.limit)=\(limit)&\(Url.Fields.offset)=\(offset)&\(Url.Fields.ts)=\(ts)&\(Url.Fields.hash)=\(hash)"
        
            return endpoint
            
        case .getStoriesWith(let characterId, let limit, let offset):
            let ts = String(format: "%f", Date().timeIntervalSince1970)
            guard let hash = "\(ts)\(Url.privateKey)\(Url.apiKey)".hashed(.md5) else {
                return "/v1/public/characters/\(characterId)/comics"
            }
            let endpoint = "/v1/public/characters/\(characterId)/stories?\(Url.Fields.apiKey)=\(Url.apiKey)&\(Url.Fields.limit)=\(limit)&\(Url.Fields.offset)=\(offset)&\(Url.Fields.ts)=\(ts)&\(Url.Fields.hash)=\(hash)"
            
            return endpoint
            
        case .getEventsWith(let characterId, let limit, let offset):
            let ts = String(format: "%f", Date().timeIntervalSince1970)
            guard let hash = "\(ts)\(Url.privateKey)\(Url.apiKey)".hashed(.md5) else {
                return "/v1/public/characters/\(characterId)/events"
            }
            let endpoint = "/v1/public/characters/\(characterId)/events?\(Url.Fields.apiKey)=\(Url.apiKey)&\(Url.Fields.limit)=\(limit)&\(Url.Fields.offset)=\(offset)&\(Url.Fields.ts)=\(ts)&\(Url.Fields.hash)=\(hash)"
            
            return endpoint
        }
    }
    
    case getCharactersWith(nameStartsWith: String?, limit: UInt, offset: UInt)
    case getComicsWith(characterId: Int32, limit: UInt, offset: UInt)
    case getSeriesWith(characterId: Int32, limit: UInt, offset: UInt)
    case getStoriesWith(characterId: Int32, limit: UInt, offset: UInt)
    case getEventsWith(characterId: Int32, limit: UInt, offset: UInt)
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
