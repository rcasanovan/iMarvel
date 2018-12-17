//
//  CharactersListViewController.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    public var presenter: CharactersListPresenterDelegate?
    
    private let searchView: SearchView = SearchView()
    private let totalResultsView: TotalResultsView = TotalResultsView()
    private let charactersListContainerView: UIView = UIView()
    private var charactersTableView: UITableView?
    private var dataSource: CharactersListDataSource?
    private let suggestionsView = SuggestionsView()
    private var suggestionsViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViews()
    }
    
}

// MARK: - Setup views
extension CharactersListViewController {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        view.backgroundColor = .black
        edgesForExtendedLayout = []
        
        configureSubviews()
        addSubviews()
        showSuggestions(show: false, height: 0.0, animated: false)
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
        searchView.delegate = self
        
        suggestionsView.delegate = self
        
        charactersTableView = UITableView(frame: charactersListContainerView.bounds, style: .plain)
        charactersTableView?.tableFooterView = UIView()
        charactersTableView?.estimatedRowHeight = 193.0
        charactersTableView?.rowHeight = UITableView.automaticDimension
        charactersTableView?.invalidateIntrinsicContentSize()
        charactersTableView?.allowsSelection = false
        charactersTableView?.backgroundColor = .black
        charactersTableView?.delegate = self
        
        registerCells()
        setupDatasource()
    }
    
    /**
     * Register all the cells we need
     */
    private func registerCells() {
        charactersTableView?.register(CharactersListTableViewCell.self, forCellReuseIdentifier: CharactersListTableViewCell.identifier)
    }
    
    /**
     * Setup datasource for the movies table view
     */
    private func setupDatasource() {
        if let charactersTableView = charactersTableView {
            dataSource = CharactersListDataSource()
            charactersTableView.dataSource = dataSource
        }
    }
    
    /**
     * Add observers to the view
     */
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}

// MARK: - Keyboard actions
extension CharactersListViewController {
    
    /**
     * Control the keyboard will appear action
     *
     * - parameters:
     *      -notification: notification from the keyboard
     */
    @objc private func keyboardWillBeAppear(notification: NSNotification) {
        guard let info:[AnyHashable:Any] = notification.userInfo,
            let keyboardSize:CGSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        presenter?.getSuggestions()
        showSuggestions(show: true, height: -keyboardSize.height, animated: true)
    }
    
    /**
     * Control the keyboard will be hidden action
     *
     * - parameters:
     *      -notification: notification from the keyboard
     */
    @objc private func keyboardWillBeHidden(notification: NSNotification) {
        showSuggestions(show: false, height: 0.0, animated: true)
    }
    
}

// MARK: - Layout & constraints
extension CharactersListViewController {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        struct Scroll {
            static let percentagePosition: Double = 75.0
        }
        
    }
    
    /**
     * Internal struct for animation
     */
    private struct Animation {
        
        static let animationDuration: TimeInterval = 0.25
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        view.addSubview(searchView)
        view.addSubview(totalResultsView)
        view.addSubview(charactersListContainerView)
        view.addSubview(suggestionsView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: searchView)
        view.addConstraintsWithFormat("V:|-\(10.0)-[v0(\(searchView.getHeight()))]", views: searchView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: totalResultsView)
        view.addConstraintsWithFormat("V:[v0][v1(\(totalResultsView.getHeight()))]", views: searchView, totalResultsView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: charactersListContainerView)
        view.addConstraintsWithFormat("V:[v0][v1]|", views: totalResultsView, charactersListContainerView)
        
        if let charactersTableView = charactersTableView {
            charactersListContainerView.addSubview(charactersTableView)
            charactersListContainerView.addConstraintsWithFormat("H:|[v0]|", views: charactersTableView)
            charactersListContainerView.addConstraintsWithFormat("V:|[v0]|", views: charactersTableView)
        }
        
        view.addConstraintsWithFormat("H:|[v0]|", views: suggestionsView)
        view.addConstraintsWithFormat("V:[v0][v1]", views: searchView, suggestionsView)
        let suggestionsViewBottomConstraint = NSLayoutConstraint(item: suggestionsView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        view.addConstraint(suggestionsViewBottomConstraint)
        self.suggestionsViewBottomConstraint = suggestionsViewBottomConstraint
    }
    
    /**
     * Show suggestions
     *
     * - parameters:
     *      -show: show / hide the suggestions
     *      -height: the height for the suggestions content
     *      -animated: show / hide suggestions with animation or not
     */
    private func showSuggestions(show: Bool, height: CGFloat, animated: Bool) {
        let animateDuration = animated ? Animation.animationDuration : 0;
        suggestionsViewBottomConstraint?.constant = height
        suggestionsView.isHidden = !show
        UIView.animate(withDuration: animateDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    /**
     * Scroll to top
     */
    private func scrollToTop() {
        charactersTableView?.setContentOffset(.zero, animated: false)
    }
    
}

// MARK: - UITableViewDelegate
extension CharactersListViewController: UITableViewDelegate {
    
}

// MARK: - IMSearchViewDelegate
extension CharactersListViewController: SearchViewDelegate {
    
    func searchButtonPressedWithSearch(search: String?) {
        guard let search = search else {
            return
        }
        presenter?.searchCharacter(search)
    }
    
}

// MARK: - IMSuggestionsViewDelegate
extension CharactersListViewController: SuggestionsViewDelegate {
    
    func suggestionSelectedAt(index: Int) {
        showSuggestions(show: false, height: 0.0, animated: false)
        searchView.hideKeyboard()
        presenter?.suggestionSelectedAt(index: index)
    }
    
}

extension CharactersListViewController: CharactersListViewInjection {
    
    func showProgress(_ show: Bool, status: String) {
    }
    
    func showProgress(_ show: Bool) {
    }
    
    func loadCharacters(_ viewModels: [CharactersListViewModel]) {
        // Are we loading the movies from the beginning? -> scroll to top
//        if fromBeginning {
            scrollToTop()
//        }
        dataSource?.characters = viewModels
        charactersTableView?.reloadData()
        totalResultsView.isHidden = true
//        totalResultsView.isHidden = totalResults == 0
//        totalResultsView.bindWithText("Total movies: \(totalResults)")
    }
    
    func showMessageWith(title: String, message: String, actionTitle: String) {
    }
    
    
}
