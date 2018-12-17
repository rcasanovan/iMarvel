//
//  CharactersListTableViewCell.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 17/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class CharactersListTableViewCell: UITableViewCell {
    
    private var backgroundImageView: UIImageView = UIImageView()
    private var backgroundLayerImageView: UIVisualEffectView?
    private var posterImageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var releaseDateLabel: UILabel = UILabel()
    private var overviewLabel: UILabel = UILabel()
    
    private var viewModel: CharactersListViewModel?
    
    static public var identifier: String {
        return String(describing: self)
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.image = nil
        posterImageView.image = nil
        titleLabel.text = ""
        releaseDateLabel.text = ""
        overviewLabel.text = ""
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
    }
}

// MARK: - Setup views
extension CharactersListTableViewCell {
    
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
        backgroundImageView.frame = self.bounds
        backgroundImageView.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        backgroundLayerImageView = UIVisualEffectView(effect: blurEffect)
        backgroundLayerImageView?.frame = self.bounds
        backgroundLayerImageView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        posterImageView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 150.0)
        posterImageView.backgroundColor = .clear
        
        titleLabel.font = UIFont.interUIMediumWithSize(size: 17.0)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.backgroundColor = .clear
        
        releaseDateLabel.font = UIFont.interUIMediumWithSize(size: 14.0)
        releaseDateLabel.textColor = .white
        
        overviewLabel.font = UIFont.interUIMediumWithSize(size: 15.0)
        overviewLabel.textColor = .white
        overviewLabel.numberOfLines = 0
    }
    
    /**
     * Configure movie information
     */
    private func configureInformation() {
        guard let viewModel = viewModel else {
            return
        }
        titleLabel.text = viewModel.name
        releaseDateLabel.text = "Jan 30, 2008"
        overviewLabel.text = viewModel.description
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
extension CharactersListTableViewCell {
    
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
        addSubview(titleLabel)
        addSubview(releaseDateLabel)
        addSubview(overviewLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: backgroundImageView)
        addConstraintsWithFormat("V:|[v0]|", views: backgroundImageView)
        
        addConstraintsWithFormat("H:|-\(Layout.PosterImageView.leading)-[v0(\(Layout.PosterImageView.width))]", views: posterImageView)
        addConstraintsWithFormat("V:|-\(Layout.PosterImageView.top)-[v0(\(Layout.PosterImageView.height))]->=\(Layout.PosterImageView.bottom)-|", views: posterImageView)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.TitleLabel.leading)-[v1]-\(Layout.TitleLabel.trailing)-|", views: posterImageView, titleLabel)
        addConstraintsWithFormat("V:|-\(Layout.TitleLabel.top)-[v0(\(Layout.TitleLabel.height))]", views: titleLabel)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.ReleaseDateLabel.leading)-[v1]-\(Layout.ReleaseDateLabel.trailing)-|", views: posterImageView, releaseDateLabel)
        addConstraintsWithFormat("V:[v0]-\(Layout.ReleaseDateLabel.top)-[v1(\(Layout.ReleaseDateLabel.height))]", views: titleLabel, releaseDateLabel)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.OverviewLabel.leading)-[v1]-\(Layout.OverviewLabel.trailing)-|", views: posterImageView, overviewLabel)
        addConstraintsWithFormat("V:[v0]-\(Layout.OverviewLabel.top)-[v1]-\(Layout.OverviewLabel.bottom)-|", views: releaseDateLabel, overviewLabel)
    }
    
}
