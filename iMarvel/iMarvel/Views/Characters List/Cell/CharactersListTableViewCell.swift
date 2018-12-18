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
    private let arrowImageView: UIImageView = UIImageView()
    
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
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        arrowImageView.image = UIImage(named: "ArrowIcon")
    }
    
}

// MARK: - Layout & constraints
extension CharactersListTableViewCell {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        struct ArrowIcon {
            static let width: CGFloat = 8.0
            static let height: CGFloat = 13.0
            static let trailing: CGFloat = 16.0
        }
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(characterInformationView)
        addSubview(arrowImageView)
        
        addConstraintsWithFormat("H:|[v0]|", views: characterInformationView)
        addConstraintsWithFormat("V:|[v0(>=0.0)]|", views: characterInformationView)
        
        addConstraintsWithFormat("H:[v0(\(Layout.ArrowIcon.width))]-\(Layout.ArrowIcon.trailing)-|", views: arrowImageView)
        addConstraintsWithFormat("V:[v0(\(Layout.ArrowIcon.height))]", views: arrowImageView)
        let arrowCenterLayoutConstraint = NSLayoutConstraint(item: arrowImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 1.0)
        addConstraint(arrowCenterLayoutConstraint)
    }
    
}
