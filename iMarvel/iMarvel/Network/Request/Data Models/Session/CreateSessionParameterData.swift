//
//  CreateSessionParameterData.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 12/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import Foundation

struct CreateSessionParameterData: Encodable {
    
    let cabinclass: String
    let country: String
    let currency: String
    let locale: String
    let locationSchema: String
    let originplace: String
    let destinationplace: String
    let outbounddate: String
    let inbounddate: String
    let adults: Int
    let children: Int
    let infants: Int
    let apikey: String
    
    init(cabinclass: String, country: String, currency: String, locale: String, locationSchema: String, originplace: String, destinationplace: String, outbounddate: String, inbounddate: String, adults: Int, children: Int, infants: Int, apikey: String) {
        self.cabinclass = cabinclass
        self.country = country
        self.currency = currency
        self.locale = locale
        self.locationSchema = locationSchema
        self.originplace = originplace
        self.destinationplace = destinationplace
        self.outbounddate = outbounddate
        self.inbounddate = inbounddate
        self.adults = adults
        self.children = children
        self.infants = infants
        self.apikey = apikey
    }
    
}
