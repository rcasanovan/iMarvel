//
//  SuggestionsDatasource.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class SuggestionsDatasource: NSObject {
    
    // Suggestions to inject to the table view
    public var suggestions: [SuggestionViewModel]
    
    public override init() {
        self.suggestions = []
        super.init()
    }
    
}

// MARK: - UITableViewDataSource
extension SuggestionsDatasource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SuggestionTableViewCell.identifier, for: indexPath) as? SuggestionTableViewCell else {
            return UITableViewCell()
        }
        
        // Get the view model and bind the cell with the information
        let viewModel = suggestions[indexPath.row]
        cell.bindWithViewModel(viewModel)
        
        return cell
    }
    
}
