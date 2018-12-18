//
//  CharacterInformationView.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class CharacterInformationView: UIView {
    
    private let backgroundImageView: UIImageView = UIImageView()
    private var backgroundLayerImageView: UIVisualEffectView?
    private let posterImageView: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    private let lastUpdateDateLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let arrowImageView: UIImageView = UIImageView()
    
    private let comicsView: PublicationView = PublicationView()
    private let seriesView: PublicationView = PublicationView()
    private let storiesView: PublicationView = PublicationView()
    private let eventsView: PublicationView = PublicationView()
    
    private var viewModel: CharactersListViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    /**
     * Bind component
     *
     * - parameters:
     *      -viewModel: CharactersListViewModel
     */
    public func bindWithViewModel(_ viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
        configureInformation()
        configureBackgroundImage()
        configurePosterImage()
        
        comicsView.value = viewModel.comics
        seriesView.value = viewModel.series
        storiesView.value = viewModel.stories
        eventsView.value = viewModel.events
    }
}

// MARK: - Setup views
extension CharacterInformationView {
    
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
        backgroundImageView.frame = CGRect(x: 0.0, y: 0.0, width: Utils.shared.screenWidth(), height: 150.0)
        backgroundImageView.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        backgroundLayerImageView = UIVisualEffectView(effect: blurEffect)
        backgroundLayerImageView?.frame = CGRect(x: 0.0, y: 0.0, width: Utils.shared.screenWidth(), height: 150.0)
        backgroundLayerImageView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        posterImageView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 150.0)
        posterImageView.backgroundColor = .clear
        
        nameLabel.font = UIFont.interUIMediumWithSize(size: 17.0)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.backgroundColor = .clear
        
        lastUpdateDateLabel.font = UIFont.interUIMediumWithSize(size: 14.0)
        lastUpdateDateLabel.textColor = .white
        
        descriptionLabel.font = UIFont.interUIMediumWithSize(size: 15.0)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
        arrowImageView.image = UIImage(named: "ArrowIcon")
        
        comicsView.title = "Comics"
        seriesView.title = "Series"
        storiesView.title = "Stories"
        eventsView.title = "Events"
    }
    
    /**
     * Configure movie information
     */
    private func configureInformation() {
        guard let viewModel = viewModel else {
            return
        }
        nameLabel.text = viewModel.name
        
        if let modifiedDate = viewModel.modifiedDate {
            lastUpdateDateLabel.text = "Last update: \(modifiedDate)"
        } else {
            lastUpdateDateLabel.text = "Last update: not available"
        }
        
        descriptionLabel.text = viewModel.description
    }
    
    /**
     * Configure background image
     */
    private func configureBackgroundImage() {
        guard let url = viewModel?.backgroundUrlImage else {
            return
        }
        backgroundImageView.hnk_setImage(from: url, placeholder: nil, success: { [weak self] (image) in
            guard let `self` = self else { return }
            
            self.backgroundImageView.contentMode = .redraw
            self.backgroundImageView.clipsToBounds = true
            self.backgroundImageView.image = image
        }) { (error) in
        }
    }
    
    /**
     * Configure poster image
     */
    private func configurePosterImage() {
        guard let url = viewModel?.posterUrlImage else {
            return
        }
        posterImageView.hnk_setImage(from: url, placeholder: nil)
    }
    
}

// MARK: - Layout & constraints
extension CharacterInformationView {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        static let height: CGFloat = 170.0
        
        struct PosterImageView {
            static let height: CGFloat = 150.0
            static let width: CGFloat = 100.0
            static let leading: CGFloat = 16.0
            static let top: CGFloat = 16.0
            static let bottom: CGFloat = 16.0
        }
        
        struct TitleLabel {
            static let height: CGFloat = 45.0
            static let top: CGFloat = 16.0
            static let leading: CGFloat = 16.0
            static let trailing: CGFloat = 16.0
        }
        
        struct ReleaseDateLabel {
            static let height: CGFloat = 17.0
            static let top: CGFloat = 8.0
            static let leading: CGFloat = 16.0
            static let trailing: CGFloat = 16.0
        }
        
        struct OverviewLabel {
            static let top: CGFloat = 8.0
            static let bottom: CGFloat = 8.0
            static let leading: CGFloat = 16.0
            static let trailing: CGFloat = 16.0
        }
        
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
        addSubview(backgroundImageView)
        
        if let backgroundLayerImageView = backgroundLayerImageView {
            addSubview(backgroundLayerImageView)
            addConstraintsWithFormat("H:|[v0]|", views: backgroundLayerImageView)
            addConstraintsWithFormat("V:|[v0]|", views: backgroundLayerImageView)
        }
        
        addSubview(posterImageView)
        addSubview(nameLabel)
        addSubview(lastUpdateDateLabel)
        addSubview(descriptionLabel)
        addSubview(arrowImageView)
        addSubview(comicsView)
        addSubview(seriesView)
        addSubview(storiesView)
        addSubview(eventsView)
        
        addConstraintsWithFormat("H:|[v0]|", views: backgroundImageView)
        addConstraintsWithFormat("V:|[v0]|", views: backgroundImageView)
        
        addConstraintsWithFormat("H:|-\(Layout.PosterImageView.leading)-[v0(\(Layout.PosterImageView.width))]", views: posterImageView)
        addConstraintsWithFormat("V:|-\(Layout.PosterImageView.top)-[v0(\(Layout.PosterImageView.height))]->=\(Layout.PosterImageView.bottom)-[v1]", views: posterImageView, comicsView)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.TitleLabel.leading)-[v1]-\(Layout.TitleLabel.trailing)-|", views: posterImageView, nameLabel)
        addConstraintsWithFormat("V:|-\(Layout.TitleLabel.top)-[v0(\(Layout.TitleLabel.height))]", views: nameLabel)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.ReleaseDateLabel.leading)-[v1]-\(Layout.ReleaseDateLabel.trailing)-|", views: posterImageView, lastUpdateDateLabel)
        addConstraintsWithFormat("V:[v0]-\(Layout.ReleaseDateLabel.top)-[v1(\(Layout.ReleaseDateLabel.height))]", views: nameLabel, lastUpdateDateLabel)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.OverviewLabel.leading)-[v1]-\(Layout.OverviewLabel.trailing)-[v2]", views: posterImageView, descriptionLabel, arrowImageView)
        addConstraintsWithFormat("V:[v0]-\(Layout.OverviewLabel.top)-[v1]-\(Layout.OverviewLabel.bottom)-|", views: lastUpdateDateLabel, descriptionLabel)
        
        addConstraintsWithFormat("H:[v0(\(Layout.ArrowIcon.width))]-\(Layout.ArrowIcon.trailing)-|", views: arrowImageView)
        addConstraintsWithFormat("V:[v0(\(Layout.ArrowIcon.height))]", views: arrowImageView)
        let arrowCenterLayoutConstraint = NSLayoutConstraint(item: arrowImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 1.0)
        addConstraint(arrowCenterLayoutConstraint)
        
        addConstraintsWithFormat("H:|-\(Layout.PosterImageView.leading)-[v0(\(Layout.PosterImageView.width))]", views: comicsView)
        addConstraintsWithFormat("V:[v0(\(comicsView.height))]-10.0-[v1]", views: comicsView, seriesView)
        
        addConstraintsWithFormat("H:|-\(Layout.PosterImageView.leading)-[v0(\(Layout.PosterImageView.width))]", views: seriesView)
        addConstraintsWithFormat("V:[v0(\(comicsView.height))]-10.0-[v1]", views: seriesView, storiesView)
        
        addConstraintsWithFormat("H:|-\(Layout.PosterImageView.leading)-[v0(\(Layout.PosterImageView.width))]", views: storiesView)
        addConstraintsWithFormat("V:[v0(\(comicsView.height))]-10.0-[v1]", views: storiesView, eventsView)
        
        addConstraintsWithFormat("H:|-\(Layout.PosterImageView.leading)-[v0(\(Layout.PosterImageView.width))]", views: eventsView)
        addConstraintsWithFormat("V:[v0(\(comicsView.height))]-16.0-|", views: eventsView)
    }
    
}

