//
//  ImageManager.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

class ImageManager {
    
    static let shared: ImageManager = { return ImageManager() }()
    
    /**
     * Internal struct for url
     */
    private struct Url {
        
        struct ImageSize {
            static let landspace: String = "landscape_amazing"
            static let portrait: String = "portrait_medium"
        }
        
    }
    
    public func getLandscapeUrlWith(_ partialUrl: String?, ext: String) -> URL? {
        guard let partialUrl = partialUrl else {
            return nil
        }
        
        let url = URL(string: partialUrl + "/" + Url.ImageSize.landspace + "." + ext)
        return url
    }
    
    public func getPortraitUrlWith(_ partialUrl: String?, ext: String) -> URL? {
        guard let partialUrl = partialUrl else {
            return nil
        }
        
        let url = URL(string: partialUrl + "/" + Url.ImageSize.portrait + "." + ext)
        return url
    }
    
}
