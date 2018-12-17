//
//  UIEdgeInsets.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import Foundation

extension UIEdgeInsets {
    
    static var safeAreaInsets: UIEdgeInsets = {
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return UIEdgeInsets.zero }
        let insets: UIEdgeInsets
        if #available(iOS 11.0, *) {
            insets = window.safeAreaInsets
        } else {
            insets = UIEdgeInsets.zero
        }
        return insets
    }()
    
}
