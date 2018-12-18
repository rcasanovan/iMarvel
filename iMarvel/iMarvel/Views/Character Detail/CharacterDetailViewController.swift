//
//  CharacterDetailViewController.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class CharacterDetailViewController: BaseViewController {
    
    public var presenter: CharacterDetailPresenterDelegate?
    
    private let characterInformationView: CharacterInformationView = CharacterInformationView()
    private let customTitleView: CustomTitleView = CustomTitleView()
    private let optionsBarView: OptionsBarView = OptionsBarView()
    
    private let comicsContainerView: UIView = UIView()
    private var comicsTableView: UITableView?
    private var dataSource: ComicsDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureNavigationBar()
        presenter?.viewDidLoad()
    }
    
}

// MARK: - Setup views
extension CharacterDetailViewController {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        view.backgroundColor = .black
        edgesForExtendedLayout = []
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
        optionsBarView.backgroundColor = .yellow
        optionsBarView.options = ["Comics", "Series", "Stories", "Events"]
        
        comicsTableView = UITableView(frame: comicsContainerView.bounds, style: .plain)
        comicsTableView?.tableFooterView = UIView()
        comicsTableView?.estimatedRowHeight = 193.0
        comicsTableView?.rowHeight = UITableView.automaticDimension
        comicsTableView?.invalidateIntrinsicContentSize()
        comicsTableView?.allowsSelection = true
        comicsTableView?.backgroundColor = .black
        
        registerCells()
        setupDatasource()
    }
    
    private func configureNavigationBar() {
        customTitleView.titleColor = .white
        customTitleView.setTitle("iMarvel")
        customTitleView.subtitleColor = .white
        navigationItem.titleView = customTitleView
    }
    
    /**
     * Register all the cells we need
     */
    private func registerCells() {
        comicsTableView?.register(ComicTableViewCell.self, forCellReuseIdentifier: ComicTableViewCell.identifier)
    }
    
    /**
     * Setup datasource for the movies table view
     */
    private func setupDatasource() {
        if let comicsTableView = comicsTableView {
            dataSource = ComicsDataSource()
            comicsTableView.dataSource = dataSource
        }
    }
    
}

// MARK: - Layout & constraints
extension CharacterDetailViewController {
    
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
        view.addSubview(characterInformationView)
        view.addSubview(optionsBarView)
        view.addSubview(comicsContainerView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: characterInformationView)
        view.addConstraintsWithFormat("V:|[v0(>=0.0)]", views: characterInformationView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: optionsBarView)
        view.addConstraintsWithFormat("V:[v0][v1(\(optionsBarView.height))]", views: characterInformationView, optionsBarView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: comicsContainerView)
        view.addConstraintsWithFormat("V:[v0][v1]|", views: optionsBarView, comicsContainerView)
        
        if let comicsTableView = comicsTableView {
            comicsContainerView.addSubview(comicsTableView)
            comicsContainerView.addConstraintsWithFormat("H:|[v0]|", views: comicsTableView)
            comicsContainerView.addConstraintsWithFormat("V:|[v0]|", views: comicsTableView)
        }
    }
    
    /**
     * Scroll to top
     */
    private func scrollToTop() {
        comicsTableView?.setContentOffset(.zero, animated: false)
    }
    
}

extension CharacterDetailViewController: CharacterDetailViewInjection {
    
    func showProgress(_ show: Bool, status: String) {
        showLoader(show, status: status)
    }
    
    func showProgress(_ show: Bool) {
        showLoader(show)
    }
    
    func loadCharacter(_ characterDetail: CharactersListViewModel) {
        characterInformationView.bindWithViewModel(characterDetail)
    }
    
    func loadComics(_ viewModels: [ComicViewModel], copyright: String?, fromBeginning: Bool) {
        // Are we loading the characters from the beginning? -> scroll to top
        if fromBeginning {
            scrollToTop()
        }
        customTitleView.setSubtitle(copyright)
        
        dataSource?.comics = viewModels
        comicsTableView?.reloadData()
    }
    
    func showMessageWith(title: String, message: String, actionTitle: String) {
        showAlertWith(title: title, message: message, actionTitle: actionTitle)
    }
    
}
