//
//  SearchView.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

protocol SearchViewDelegate {
    func searchButtonPressedWithSearch(search: String?)
}

class SearchView: UIView {
    
    public var delegate: SearchViewDelegate?
    
    private let searchContainerView: UIView = UIView()
    private var searchContainerViewTrailingConstraint: NSLayoutConstraint?
    
    private let searchBar: UISearchBar = UISearchBar()
    
    private let cancelButton: UIButton = UIButton(type: .custom)
    private var cancelButtonWidthConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    /**
     * Get component's height
     */
    public func getHeight() -> CGFloat {
        return Layout.height
    }
    
    /**
     * Hide keyboard
     */
    public func hideKeyboard() {
        searchBar.resignFirstResponder()
        showCancel(show: false, animated: true)
    }
    
}

// MARK: - Setup views
extension SearchView {
    
    private func setupViews() {
        backgroundColor = .black
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        searchContainerView.backgroundColor = .clear
        
        searchBar.placeholder = "Search your favorites characters"
        searchBar.backgroundColor = .clear
        searchBar.barTintColor = .clear
        searchBar.delegate = self
        
        cancelButton.setBackgroundImage(UIImage(named: "CancelButton"), for: .normal)
        cancelButton.setBackgroundImage(UIImage(named: "CancelButtonPressed"), for: .selected)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
    }
    
}

// MARK: - Layout & constraints
extension SearchView {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        static let height: CGFloat = 46.0
        
        struct SearchContainerView {
            static let leading: CGFloat = 7.0
            static let trailing: CGFloat = -7.0
            static let trailingSelected: CGFloat = -115.0
        }
        
        struct CancelButton {
            static let trailing: CGFloat = 15.0
            static let top: CGFloat = 7.0
            static let height: CGFloat = 31.0
            static let width: CGFloat = 93.0
        }
        
    }
    
    /**
     * Internal struct for animation
     */
    private struct Animation {
        
        static let animationDuration: TimeInterval = 0.45
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(searchContainerView)
        addSubview(cancelButton)
        searchContainerView.addSubview(searchBar)
        
        addConstraintsWithFormat("H:|-\(Layout.SearchContainerView.leading)-[v0]", views: searchContainerView)
        let searchContainerViewTrailingConstraint = NSLayoutConstraint(item: searchContainerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: Layout.SearchContainerView.trailing)
        addConstraint(searchContainerViewTrailingConstraint)
        self.searchContainerViewTrailingConstraint = searchContainerViewTrailingConstraint
        addConstraintsWithFormat("V:|[v0]|", views: searchContainerView)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.CancelButton.trailing)-|", views: cancelButton)
        addConstraintsWithFormat("V:|-\(Layout.CancelButton.top)-[v0(\(Layout.CancelButton.height))]", views: cancelButton)
        let cancelButtonWidthConstraint = NSLayoutConstraint(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 0.0)
        addConstraint(cancelButtonWidthConstraint)
        self.cancelButtonWidthConstraint = cancelButtonWidthConstraint
        
        searchContainerView.addConstraintsWithFormat("H:|[v0]|", views: searchBar)
        searchContainerView.addConstraintsWithFormat("V:|[v0]|", views: searchBar)
    }
    
    /**
     * Show / hide cancel action
     *
     * - parameters:
     *      -show: show / hide the cancel action
     *      -animated: show / hide cancel action with animation or not
     */
    private func showCancel(show: Bool, animated: Bool) {
        let animateDuration = animated ? Animation.animationDuration : 0;
        cancelButtonWidthConstraint?.constant = show ? Layout.CancelButton.width : 0.0;
        searchContainerViewTrailingConstraint?.constant = show ? Layout.SearchContainerView.trailingSelected : Layout.SearchContainerView.trailing;
        
        if !show {
            searchBar.text = ""
        }
        
        UIView.animate(withDuration: animateDuration) {
            self.layoutIfNeeded()
        }
    }
    
}

// MARK: - UISearchBarDelegate
extension SearchView: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showCancel(show: true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        delegate?.searchButtonPressedWithSearch(search: searchBar.text)
        showCancel(show: false, animated: true)
    }
    
}

// MARK: - User actions
extension SearchView {
    
    @objc private func cancelButtonPressed() {
        showCancel(show: false, animated: true)
        searchBar.resignFirstResponder()
    }
    
}
