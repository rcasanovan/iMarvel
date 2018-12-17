//
//  CharactersListDataSource.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class CharactersListDataSource: NSObject {
    
    public var characters: [CharactersListViewModel]
    
    public override init() {
        self.characters = []
        super.init()
    }
    
}

// MARK: - UITableViewDataSource
extension CharactersListDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersListTableViewCell.identifier, for: indexPath) as? CharactersListTableViewCell else {
            return UITableViewCell()
        }
        
        // Get the view model and bind the cell with the information
        let viewModel = characters[indexPath.row]
        cell.bindWithViewModel(viewModel)
        
        return cell
    }
    
}
