//
//  ComicsDataSource.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class ComicsDataSource: NSObject {
    
    public var comics: [ComicViewModel]
    
    public override init() {
        self.comics = []
        super.init()
    }
    
}

// MARK: - UITableViewDataSource
extension ComicsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicTableViewCell.identifier, for: indexPath) as? ComicTableViewCell else {
            return UITableViewCell()
        }
        
        // Get the view model and bind the cell with the information
        let viewModel = comics[indexPath.row]
        cell.bindWithViewModel(viewModel)
        
        return cell
    }
    
}
