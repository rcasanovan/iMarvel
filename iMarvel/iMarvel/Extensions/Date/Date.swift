//
//  Date.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

extension Date {
    
    public static func getISODateWithString(_ stringDate: String) -> Date? {
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-SSS'Z'"
        isoFormatter.locale = Locale(identifier: "en_US_POSIX")
        return isoFormatter.date(from: stringDate)
    }
    
    public func getStringMMMddyyyyFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
    
}
