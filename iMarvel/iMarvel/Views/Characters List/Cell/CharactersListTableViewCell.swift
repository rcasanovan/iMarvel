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
    }
    
    /**
     * Bind component
     *
     * - parameters:
     *      -viewModel: IMMovieViewModel
     */
    public func bindWithViewModel(_ viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
        configureBackgroundImage()
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
    }
    
    /**
     * Configure background image
     */
    private func configureBackgroundImage() {
        guard let url = viewModel?.urlImage else {
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
    
}

// MARK: - Layout & constraints
extension CharactersListTableViewCell {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        struct PosterImageView {
            static let height: CGFloat = 138.0
            static let width: CGFloat = 92.0
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
        
        struct StarRating {
            static let height: CGFloat = 15.0
            static let width: CGFloat = 100.0
            static let top: CGFloat = 8.0
            static let leading: CGFloat = 8.0
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
        
        addConstraintsWithFormat("H:|[v0]|", views: backgroundImageView)
        addConstraintsWithFormat("V:|[v0]|", views: backgroundImageView)
    }
    
}
