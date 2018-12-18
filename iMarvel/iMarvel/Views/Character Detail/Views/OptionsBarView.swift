//
//  OptionsBarView.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class OptionsBarView: UIView {
    
    public var options: [String] = [String]() {
        didSet {
            clear()
            setupViews()
        }
    }
    
    public var height: CGFloat {
        return Layout.height
    }
    
    private var optionWidth: CGFloat = 0.0
    private let separatorView: UIView = UIView()
    private var separatorViewLeadingLayout: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func clear() {
        removeAllSubviews()
    }
}

// MARK: - Setup views
extension OptionsBarView {
    
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
        if options.count > 0 {
            optionWidth = Utils.shared.screenWidth() / CGFloat(options.count)
        }
        
        separatorView.backgroundColor = .white
    }
    
}

// MARK: - Layout & constraints
extension OptionsBarView {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        static let height: CGFloat = 40.0
        
        struct SeparatorView {
            static let height: CGFloat = 2.0
        }
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        var leading: CGFloat = 0.0
        var tag: Int = 0
        
        for eachOption in options {
            let button = UIButton(type: .custom)
            button.setTitle(eachOption, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.interUIMediumWithSize(size: 14.0)
            button.addTarget(self, action:#selector(buttonPressed(sender:)), for: .touchUpInside)
            button.tag = tag

            
            addSubview(button)
            
            addConstraintsWithFormat("H:|-\(leading)-[v0(\(optionWidth))]", views: button)
            addConstraintsWithFormat("V:|[v0]|", views: button)
            
            leading = leading + optionWidth
            tag = tag + 1
        }
        
        addSubview(separatorView)
        addConstraintsWithFormat("H:[v0(\(optionWidth))]", views: separatorView)
        addConstraintsWithFormat("V:[v0(\(Layout.SeparatorView.height))]|", views: separatorView)
        let separatorViewLeadingLayout = NSLayoutConstraint(item: separatorView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        self.separatorViewLeadingLayout = separatorViewLeadingLayout
        addConstraint(separatorViewLeadingLayout)
    }
    
}

// MARK: - OptionsBarView
extension OptionsBarView {
    
    @objc func buttonPressed(sender: UIButton) {
        self.separatorViewLeadingLayout?.constant = self.optionWidth * CGFloat(sender.tag)
        
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
}

