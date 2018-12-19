//
//  PublicationView.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class PublicationView: UIView {
    
    private let bubbleView: BubbleView = BubbleView()
    private let totalResultsLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    public var height: CGFloat {
        return Layout.height
    }
    
    public var value: String? {
        didSet {
            bubbleView.value = value
        }
    }
    
    public var title: String? {
        didSet {
            totalResultsLabel.text = title
        }
    }
    
}

// MARK: - Setup views
extension PublicationView {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .clear
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
        bubbleView.width = 16.0
        totalResultsLabel.font = UIFont.interUIBoldWithSize(size: 14.0)
        totalResultsLabel.textAlignment = .left
        totalResultsLabel.textColor = .white()
    }
    
}

// MARK: - Layout & constraints
extension PublicationView {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        static let height: CGFloat = 16.0
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(bubbleView)
        addSubview(totalResultsLabel)
        
        addConstraintsWithFormat("H:[v0(16.0)]|", views: bubbleView)
        addConstraintsWithFormat("V:|[v0(16.0)]|", views: bubbleView)
        
        addConstraintsWithFormat("H:|[v0]-10.0-[v1]", views: totalResultsLabel, bubbleView)
        addConstraintsWithFormat("V:|[v0]|", views: bubbleView)
    }
    
}
