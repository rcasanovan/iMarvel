//
//  EndPoint.swift
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit

protocol EndpointProtocol: RawRepresentable where RawValue == String {
    var baseUrl: URL? { get }
    var url: URL? { get }
}

/**
 * Internal struct for Url
 */
private struct Url {
    
    static let baseUrl: String = "http://partners.api.skyscanner.net/apiservices"
    static let apiKey: String = "ss630745725358065467897349852985"
    
    struct Fields {
        static let apikey: String = "apikey"
        static let pageIndex: String = "pageIndex"
        static let pageSize: String = "pageSize"
    }
    
}

// MARK: - Endpoints
enum Endpoint: EndpointProtocol {
    
    var rawValue: String {
        switch self {
        case .createSession():
            return "/pricing/v1.0"
        case .pollResultsWith(let pollEndpoint, let pageIndex, let pageSize):
            return "\(pollEndpoint)?\(Url.Fields.apikey)=\(Url.apiKey)&\(Url.Fields.pageIndex)=\(pageIndex)&\(Url.Fields.pageSize)=\(pageSize)"
        }
    }
    
    case createSession()
    case pollResultsWith(pollEndpoint: String, pageIndex: UInt, pageSize: UInt)
}

extension EndpointProtocol {
    
    init?(rawValue: String) {
        assertionFailure("init(rawValue:) not implemented")
        return nil
    }
    
    var baseUrl: URL? {
        let urlComponents = URLComponents(string: Url.baseUrl + self.rawValue)
        return urlComponents?.url
    }
    
    var url: URL? {
        let urlComponents = URLComponents(string: self.rawValue)
        return urlComponents?.url
    }
    
}
