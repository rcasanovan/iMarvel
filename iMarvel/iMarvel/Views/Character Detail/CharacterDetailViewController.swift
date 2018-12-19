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
    
    private let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .white)
    private let comicsContainerView: UIView = UIView()
    private var comicsTableView: UITableView?
    private var dataSource: ComicsDataSource?
    
    private var totalComics: Int = 0
    private var isLoadingNextPage: Bool = false
    private var allComicsLoaded: Bool = false
    
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
        view.backgroundColor = .black()
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
        optionsBarView.delegate = self
        
        comicsTableView = UITableView(frame: comicsContainerView.bounds, style: .plain)
        comicsTableView?.tableFooterView = UIView()
        comicsTableView?.estimatedRowHeight = 193.0
        comicsTableView?.rowHeight = UITableView.automaticDimension
        comicsTableView?.invalidateIntrinsicContentSize()
        comicsTableView?.allowsSelection = true
        comicsTableView?.backgroundColor = .black()
        comicsTableView?.delegate = self
        
        registerCells()
        setupDatasource()

    }
    
    private func configureNavigationBar() {
        customTitleView.titleColor = .white()
        customTitleView.setTitle("iMarvel")
        customTitleView.subtitleColor = .white()
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

extension CharacterDetailViewController: OptionsBarViewDelegate {
    
    func optionSelectedAt(_ index: Int) {
        switch index {
        case 0:
            presenter?.optionSelected(.comics)
        case 1:
            presenter?.optionSelected(.series)
        case 2:
            presenter?.optionSelected(.stories)
        case 3:
            presenter?.optionSelected(.events)
        default:
            print("do nothing")
        }
    }
    
}

// MARK: - UITableViewDelegate
extension CharacterDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            comicsTableView?.tableFooterView = allComicsLoaded ? UIView() : spinner
            comicsTableView?.tableFooterView?.isHidden = allComicsLoaded
        }
        
        // Get the position for a percentage of the scrolling
        // In this case we got the positions for the 75%
        let position = Int(((Layout.Scroll.percentagePosition * Double(totalComics - 1)) / 100.0))
        
        // if we're not loading a next page && we´re in the 75% position
        if !self.isLoadingNextPage && indexPath.item >= position {
            // Change the value -> We're loading the next page
            self.isLoadingNextPage = true
            optionsBarView.isUserInteractionEnabled = allComicsLoaded
            // Call the presenter
            presenter?.loadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.comicSelectedAt(indexPath.row)
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
    
    func loadComics(_ viewModels: [ComicViewModel], copyright: String?, fromBeginning: Bool, allComicsLoaded: Bool) {
        self.allComicsLoaded = allComicsLoaded
        
        // Are we loading the characters from the beginning? -> scroll to top
        if fromBeginning {
            scrollToTop()
        }
        customTitleView.setSubtitle(copyright)
        optionsBarView.isUserInteractionEnabled = true
        
        isLoadingNextPage = false
        totalComics = viewModels.count
        
        dataSource?.comics = viewModels
        comicsTableView?.tableFooterView = UIView()
        comicsTableView?.reloadData()
    }
    
    func showMessageWith(title: String, message: String, actionTitle: String) {
        showAlertWith(title: title, message: message, actionTitle: actionTitle)
    }
    
}
