//
//  MovieDetailsView.swift
//  Flix
//
//  Created by Nathan Ansel on 8/3/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {
	private let backgroundImageView = UIImageView()
	private let posterImageView = UIImageView()
	private let titleLabel = UILabel()
	private let overviewLabel = UILabel()
	private let releaseDateLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		prepareViewForConstraints(backgroundImageView)
		prepareViewForConstraints(posterImageView)
		prepareViewForConstraints(titleLabel)
		prepareViewForConstraints(overviewLabel)
		prepareViewForConstraints(releaseDateLabel)
		
		NSLayoutConstraint.activate([
			backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
			backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			
			posterImageView.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor),
			posterImageView.centerYAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
			posterImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
			posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: (2.0 / 3.0)),
			posterImageView.heightAnchor.constraint(equalToConstant: 120),
			
			titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 12),
			titleLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12),
			titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
			
			overviewLabel.topAnchor.constraint(greaterThanOrEqualTo: posterImageView.bottomAnchor, constant: 12),
			overviewLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 12),
			overviewLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
			overviewLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
			overviewLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
		])
		
		backgroundColor = .black
		
		titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
		titleLabel.textColor = .white
		titleLabel.numberOfLines = 0
		
		overviewLabel.font = UIFont.preferredFont(forTextStyle: .body)
		overviewLabel.textColor = .white
		overviewLabel.numberOfLines = 0
		
		posterImageView.backgroundColor = UIColor(red:0.98, green:0.10, blue:0.31, alpha:1.00)
	}
	
	func updateInterface(with movie: Movie?) {
		titleLabel.text = movie?.title
		overviewLabel.text = movie?.overview
	}
}
