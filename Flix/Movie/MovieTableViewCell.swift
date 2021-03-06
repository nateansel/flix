//
//  MovieTableViewCell.swift
//  Flix
//
//  Created by Nathan Ansel on 7/31/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

extension Cell {
	static let movie: ReusableCell<MovieTableViewCell> = {
		let string = String(describing: MovieTableViewCell.self)
		return ReusableCell(identifier: string)
	}()
}

class MovieTableViewCell: UITableViewCell {
	private let titleLabel = UILabel()
	private let overviewLabel = UILabel()
	private let posterImageView = UIImageView()
	
	private let manager = ImageManager.shared
	
	func updateInterface(for movie: Movie?) {
		titleLabel.text = movie?.title
		overviewLabel.text = movie?.overview
		posterImageView.image = movie?.poster
		if movie?.poster == nil {
			posterImageView.image = #imageLiteral(resourceName: "default_poster")
			if let path = movie?.posterPath {
				manager.smallPoster(
					forPath: path,
					success: { (image) in
						movie?.poster = image
						self.posterImageView.image = image
					}, failure: { (error) in
						print(error)
				})
			}
		}
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		contentView.prepareViewForConstraints(titleLabel)
		contentView.prepareViewForConstraints(overviewLabel)
		contentView.prepareViewForConstraints(posterImageView)
		NSLayoutConstraint.activate([
			// Poster
			posterImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			posterImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			posterImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
			posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: (2.0 / 3.0)),
			posterImageView.heightAnchor.constraint(equalToConstant: 120),
			
			// Title
			titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
			
			// Overview
			overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
			overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			overviewLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
		])
		
		posterImageView.contentMode = .scaleAspectFit
		titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
		overviewLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
		overviewLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
		
		titleLabel.numberOfLines = 0
		titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
		titleLabel.adjustsFontForContentSizeCategory = true
//		titleLabel.textColor = .white
		
		overviewLabel.numberOfLines = 0
		overviewLabel.font = UIFont.preferredFont(forTextStyle: .body)
		overviewLabel.adjustsFontForContentSizeCategory = true
//		overviewLabel.textColor = .white
		
		posterImageView.backgroundColor = UIColor(red:0.98, green:0.10, blue:0.31, alpha:1.00)
//		backgroundColor = .black
	}
}
