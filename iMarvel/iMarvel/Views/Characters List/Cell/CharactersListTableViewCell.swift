//
//  CharactersListTableViewCell.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class CharactersListTableViewCell: UITableViewCell {
    
    private let characterInformationView: CharacterInformationView = CharacterInformationView()
    
    static public var identifier: String {
        return String(describing: self)
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        characterInformationView.clear()
    }
    
    /**
     * Bind component
     *
     * - parameters:
     *      -viewModel: CharactersListViewModel
     */
    public func bindWithViewModel(_ viewModel: CharactersListViewModel) {
        characterInformationView.bindWithViewModel(viewModel)
    }
}

// MARK: - Setup views
extension CharactersListTableViewCell {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubviews()
    }
    
}

// MARK: - Layout & constraints
extension CharactersListTableViewCell {
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(characterInformationView)
        
        addConstraintsWithFormat("H:|[v0]|", views: characterInformationView)
        addConstraintsWithFormat("V:|[v0(>=0.0)]|", views: characterInformationView)
    }
    
}
