//
//  CharactersListViewController.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    public var presenter: CharactersListPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension CharactersListViewController: CharactersListViewInjection {
    
}
