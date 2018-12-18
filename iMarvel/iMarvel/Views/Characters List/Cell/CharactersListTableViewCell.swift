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
    private var nameLabel: UILabel = UILabel()
    private var lastUpdateDateLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private var arrowImageView: UIImageView = UIImageView()
    
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
        nameLabel.text = ""
        lastUpdateDateLabel.text = ""
        descriptionLabel.text = ""
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
        selectionStyle = .none
        
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
        
        addConstraintsWithFormat("H:|[v0]|", views: backgroundImageView)
        addConstraintsWithFormat("V:|[v0]|", views: backgroundImageView)
        
        addConstraintsWithFormat("H:|-\(Layout.PosterImageView.leading)-[v0(\(Layout.PosterImageView.width))]", views: posterImageView)
        addConstraintsWithFormat("V:|-\(Layout.PosterImageView.top)-[v0(\(Layout.PosterImageView.height))]->=\(Layout.PosterImageView.bottom)-|", views: posterImageView)
        
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
    }
    
}
