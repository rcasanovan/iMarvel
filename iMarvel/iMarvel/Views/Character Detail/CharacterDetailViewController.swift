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
    }
    
    private func configureNavigationBar() {
        customTitleView.titleColor = .white
        customTitleView.setTitle("iMarvel")
        customTitleView.subtitleColor = .white
        navigationItem.titleView = customTitleView
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
        
        view.addConstraintsWithFormat("H:|[v0]|", views: characterInformationView)
        view.addConstraintsWithFormat("V:|[v0(>=0.0)]", views: characterInformationView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: optionsBarView)
        view.addConstraintsWithFormat("V:[v0][v1(\(optionsBarView.height))]", views: characterInformationView, optionsBarView)
    }
    
}

extension CharacterDetailViewController: CharacterDetailViewInjection {
    
    func loadCharacter(_ characterDetail: CharactersListViewModel) {
        characterInformationView.bindWithViewModel(characterDetail)
    }
    
}
