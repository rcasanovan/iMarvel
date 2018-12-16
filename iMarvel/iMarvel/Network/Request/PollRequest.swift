//
//  PollRequest.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 12/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import Foundation

struct PollRequest: RequestProtocol {
    
    typealias ResponseType = PollResponse
    var completion: ((Result<PollResponse?>) -> Void)?
    var method: HTTPMethod = .get
    var url: URL? = nil
    var encodableBody: Encodable?
    var simulatedResponseJSONFile: String?
    var verbose: Bool?
    var contentType: ContentType = .json
    var processHeader: Bool?
    
    init(pollEndpoint: String, pageIndex: UInt, pageSize: UInt) {
        url = Endpoint.pollResultsWith(pollEndpoint: pollEndpoint, pageIndex: pageIndex, pageSize: pageSize).url
    }
    
}
