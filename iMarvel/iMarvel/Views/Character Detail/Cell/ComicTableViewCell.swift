//
//  ComicTableViewCell.swift
//  iMarvel
//
//  Created by Ricardo Casanova on 18/12/2018.
//  Copyright © 2018 Wallapop. All rights reserved.
//

import UIKit

class ComicTableViewCell: UITableViewCell {
    
    private let posterImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let arrowImageView: UIImageView = UIImageView()
    
    private var viewModel: ComicViewModel?
    
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
        posterImageView.image = nil
        titleLabel.text = ""
        descriptionLabel.text = ""
    }
    
    /**
     * Bind component
     *
     * - parameters:
     *      -viewModel: ComicViewModel
     */
    public func bindWithViewModel(_ viewModel: ComicViewModel) {
        self.viewModel = viewModel
        configureInformation()
        configurePosterImage()
    }
    
    /**
     * Configure movie information
     */
    private func configureInformation() {
        guard let viewModel = viewModel else {
            return
        }
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
    
    /**
     * Configure poster image
     */
    private func configurePosterImage() {
        guard let url = viewModel?.urlImage else {
            return
        }
        posterImageView.hnk_setImage(from: url, placeholder: nil)
    }
    
}

// MARK: - Setup views
extension ComicTableViewCell {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .black
        selectionStyle = .none
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        posterImageView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 150.0)
        posterImageView.backgroundColor = .clear
        
        titleLabel.font = UIFont.interUIMediumWithSize(size: 17.0)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.backgroundColor = .clear
        
        descriptionLabel.font = UIFont.interUIMediumWithSize(size: 15.0)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
        arrowImageView.image = UIImage(named: "ArrowIcon")
    }
    
}

// MARK: - Layout & constraints
extension ComicTableViewCell {
    
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
            static let trailing: CGFloat = 40.0
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
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(arrowImageView)
        
        addConstraintsWithFormat("H:|-\(Layout.PosterImageView.leading)-[v0(\(Layout.PosterImageView.width))]", views: posterImageView)
        addConstraintsWithFormat("V:|-\(Layout.PosterImageView.top)-[v0(\(Layout.PosterImageView.height))]->=\(Layout.PosterImageView.bottom)-|", views: posterImageView)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.TitleLabel.leading)-[v1]-\(Layout.TitleLabel.trailing)-|", views: posterImageView, titleLabel)
        addConstraintsWithFormat("V:|-\(Layout.TitleLabel.top)-[v0(\(Layout.TitleLabel.height))]", views: titleLabel)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.OverviewLabel.leading)-[v1]-\(Layout.OverviewLabel.trailing)-|", views: posterImageView, descriptionLabel)
        addConstraintsWithFormat("V:[v0]-\(Layout.OverviewLabel.top)-[v1]-\(Layout.OverviewLabel.bottom)-|", views: titleLabel, descriptionLabel)
        
        addConstraintsWithFormat("H:[v0(\(Layout.ArrowIcon.width))]-\(Layout.ArrowIcon.trailing)-|", views: arrowImageView)
        addConstraintsWithFormat("V:[v0(\(Layout.ArrowIcon.height))]", views: arrowImageView)
        let arrowCenterLayoutConstraint = NSLayoutConstraint(item: arrowImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 1.0)
        addConstraint(arrowCenterLayoutConstraint)
    }
    
}
