//
//  Utils.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

class Utils {
    
    static let shared: Utils = { return Utils() }()
    
    public func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    public func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
}
