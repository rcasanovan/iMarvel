//
//  BubbleView.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class BubbleView: UIView {
    
    private let backgroundView: UIView = UIView()
    private let countLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    public var value: String? {
        didSet {
            countLabel.text = value
        }
    }
    
    public var width: CGFloat = 0.0 {
        didSet {
            backgroundView.layer.cornerRadius = width / 2.0
            backgroundView.clipsToBounds = true
        }
    }
    
}

// MARK: - Setup views
extension BubbleView {
    
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
        countLabel.font = UIFont.interUIMediumWithSize(size: 12.0)
        countLabel.minimumScaleFactor = 0.1    //or whatever suits your need
        countLabel.adjustsFontSizeToFitWidth = true
        countLabel.lineBreakMode = .byClipping
        countLabel.numberOfLines = 0
        countLabel.textAlignment = .center
        countLabel.textColor = .white
        
        backgroundView.backgroundColor = .red
    }

    public func bindWithText(_ text: String) {
        countLabel.text = text
    }
    
}

// MARK: - Layout & constraints
extension BubbleView {
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(backgroundView)
        addSubview(countLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: backgroundView)
        addConstraintsWithFormat("V:|[v0]|", views: backgroundView)
        
        addConstraintsWithFormat("H:|[v0]|", views: countLabel)
        addConstraintsWithFormat("V:|[v0]|", views: countLabel)
    }
    
}
