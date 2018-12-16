//
//  SessionRequest.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 12/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import Foundation

struct SessionRequest: RequestProtocol {

    typealias ResponseType = CreateSessionResponse
    var completion: ((Result<CreateSessionResponse?>) -> Void)?
    var method: HTTPMethod = .post
    var url: URL? = Endpoint.createSession().baseUrl
    var encodableBody: Encodable?
    var simulatedResponseJSONFile: String?
    var verbose: Bool?
    var contentType: ContentType = .urlencoded
    var processHeader: Bool? = true
    
}
