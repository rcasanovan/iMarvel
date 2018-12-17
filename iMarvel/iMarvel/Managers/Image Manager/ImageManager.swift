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
        }
        
    }
    
    public func getLandscapeUrlWith(_ partialUrl: String?, extension: String) -> URL? {
        guard let partialUrl = partialUrl else {
            return nil
        }
        
        var components = getURLComponents()
        components.path = partialUrl + Url.ImageSize.landspace + partialUrl
        return components.url
    }
    
}

// MARK: - Private section
extension ImageManager {
    
    /**
     * Get url components
     */
    private func getURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "http"
        return components
    }
    
}
