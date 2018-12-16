//
//  PollResponse.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 12/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import Foundation

public struct PollResponse: Decodable {
    
    let SessionKey: String
    let Itineraries: [ItineraryResponse]
    let Legs: [LegResponse]
    let Segments: [SegmentResponse]
    let Carriers: [CarrierResponse]
    let Agents: [AgentResponse]
    let Places: [PlaceResponse]
    let Currencies: [CurrencyResponse]
    
}

public struct ItineraryResponse: Decodable {
    
    let OutboundLegId: String
    let InboundLegId: String
    let PricingOptions: [PricingOptionResponse]
    
}

public struct PricingOptionResponse: Decodable {
    
    let Agents: [Int32]
    let QuoteAgeInMinutes: Int
    let Price: Double
    let DeeplinkUrl: String
    
}

public struct LegResponse: Decodable {
    
    let Id: String
    let SegmentIds: [Int]
    let OriginStation: Int32
    let DestinationStation: Int32
    let Departure: String
    let Arrival: String
    let Duration: Int
    let JourneyMode: String
    let Stops: [Int32]
    let Carriers: [Int32]
    let OperatingCarriers: [Int32]
    let Directionality: String
    let FlightNumbers: [FlightNumberResponse]
    
}

public struct FlightNumberResponse: Decodable {
    
    let FlightNumber: String
    let CarrierId: Int32
    
}

public struct SegmentResponse: Decodable {
    
    let Id: Int32
    let OriginStation: Int32
    let DestinationStation: Int32
    let DepartureDateTime: String
    let ArrivalDateTime: String
    let Carrier: Int32
    let OperatingCarrier: Int32
    let Duration: Int
    let FlightNumber: String
    let JourneyMode: String
    let Directionality: String
    
}

public struct CarrierResponse: Decodable {
    
    let Id: Int32
    let Code: String
    let Name: String
    let ImageUrl: String
    let DisplayCode: String
    
}

public struct AgentResponse: Decodable {
    
    let Id: Int32
    let Name: String
    let ImageUrl: String
    let Status: String
    let OptimisedForMobile: Bool
    let BookingNumber: String?
    
}

public struct PlaceResponse: Decodable {
    
    let Id: Int32
    let ParentId: Int32?
    let Code: String
    let Name: String
    
}

public struct CurrencyResponse: Decodable {
    let Code: String
    let Symbol: String
    let SymbolOnLeft: Bool
}


