//
//  SuggestionsView.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

protocol SuggestionsViewDelegate {
    func suggestionSelectedAt(index: NSInteger)
}

class SuggestionsView: UIView {
    
    public var delegate: SuggestionsViewDelegate?
    
    public var suggestions: [SuggestionViewModel] = [SuggestionViewModel]() {
        didSet {
            suggestionsTableView?.isHidden = suggestions.isEmpty
            noSuggestionsLabel.isHidden = !suggestions.isEmpty
            datasource?.suggestions = suggestions
            suggestionsTableView?.reloadData()
        }
    }
    
    private let noSuggestionsLabel = UILabel()
    private var suggestionsTableView: UITableView?
    private var datasource: SuggestionsDatasource?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
}

// MARK: - Setup views
extension SuggestionsView {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .white
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
        suggestionsTableView = UITableView(frame: self.bounds, style: .plain)
        suggestionsTableView?.tableFooterView = UIView()
        suggestionsTableView?.estimatedRowHeight = 44.0
        suggestionsTableView?.rowHeight = 44.0
        suggestionsTableView?.delegate = self
        
        registerCells()
        setupDatasource()
        
        noSuggestionsLabel.font = UIFont.interUIMediumWithSize(size: 14.0)
        noSuggestionsLabel.textColor = .lightGray
        noSuggestionsLabel.textAlignment = .center
        noSuggestionsLabel.text = "No suggestions"
    }
    
    /**
     * Register all the cells we need
     */
    private func registerCells() {
        suggestionsTableView?.register(SuggestionTableViewCell.self, forCellReuseIdentifier: SuggestionTableViewCell.identifier)
    }
    
    /**
     * Setup datasource for the suggestions table view
     */
    private func setupDatasource() {
        if let suggestionsTableView = suggestionsTableView {
            datasource = SuggestionsDatasource()
            suggestionsTableView.dataSource = datasource
        }
    }
    
}

// MARK: - Layout & constraints
extension SuggestionsView {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        struct NoSuggestionsLabel {
            static let height: CGFloat = 17.0
        }
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(noSuggestionsLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: noSuggestionsLabel)
        addConstraintsWithFormat("V:[v0(\(Layout.NoSuggestionsLabel.height))]", views: noSuggestionsLabel)
        let xConstraint = NSLayoutConstraint(item: noSuggestionsLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: noSuggestionsLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraint(xConstraint)
        addConstraint(yConstraint)
        
        if let suggestionsTableView = suggestionsTableView {
            addSubview(suggestionsTableView)
            addConstraintsWithFormat("H:|[v0]|", views: suggestionsTableView)
            addConstraintsWithFormat("V:|[v0]|", views: suggestionsTableView)
        }
    }
    
}

// MARK: - UITableViewDelegate
extension SuggestionsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.suggestionSelectedAt(index: indexPath.row)
    }
    
}
