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
	private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
	private let posterImageView = UIImageView()
	private let titleLabel = UILabel()
	private let cardView = UIView()
	private let releaseDateLabel = UILabel()
	private let overviewLabel = UILabel()
	
	private let manager = ImageManager()
	
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
		prepareViewForConstraints(blurView)
		prepareViewForConstraints(cardView)
		cardView.prepareViewForConstraints(releaseDateLabel)
		cardView.prepareViewForConstraints(overviewLabel)
		prepareViewForConstraints(posterImageView)
		prepareViewForConstraints(titleLabel)
		
		NSLayoutConstraint.activate([
			backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
			backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
			backgroundImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 300),
			
			blurView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -4),
			blurView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
			blurView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
			blurView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
			
			posterImageView.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor),
			posterImageView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 24),
			posterImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
			posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: (2.0 / 3.0)),
			posterImageView.heightAnchor.constraint(equalToConstant: 120),
			
			titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 24),
			titleLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12),
			titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
			
			cardView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
			cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
			cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
			cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
			
			releaseDateLabel.topAnchor.constraint(greaterThanOrEqualTo: posterImageView.bottomAnchor, constant: 12),
			releaseDateLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 12),
			releaseDateLabel.topAnchor.constraint(equalTo: cardView.layoutMarginsGuide.topAnchor),
			releaseDateLabel.leadingAnchor.constraint(equalTo: cardView.layoutMarginsGuide.leadingAnchor),
			releaseDateLabel.trailingAnchor.constraint(equalTo: cardView.layoutMarginsGuide.trailingAnchor),
			
			overviewLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 12),
			overviewLabel.leadingAnchor.constraint(equalTo: cardView.layoutMarginsGuide.leadingAnchor),
			overviewLabel.trailingAnchor.constraint(equalTo: cardView.layoutMarginsGuide.trailingAnchor),
			overviewLabel.bottomAnchor.constraint(equalTo: cardView.layoutMarginsGuide.bottomAnchor)
		])
		
//		backgroundColor = .black
//		cardView.backgroundColor = .black
		
		titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
//		titleLabel.textColor = .white
		titleLabel.numberOfLines = 0
		
		releaseDateLabel.font = UIFont.preferredFont(forTextStyle: .headline)
		releaseDateLabel.numberOfLines = 0
		
		overviewLabel.font = UIFont.preferredFont(forTextStyle: .body)
//		overviewLabel.textColor = .white
		overviewLabel.numberOfLines = 0
		
		posterImageView.backgroundColor = UIColor(red:0.98, green:0.10, blue:0.31, alpha:1.00)
		backgroundImageView.contentMode = .scaleAspectFill
	}
	
	func updateInterface(with movie: Movie?) {
		titleLabel.text = movie?.title
		overviewLabel.text = movie?.overview
		posterImageView.image = movie?.poster
		if let date = movie?.releaseDate {
			let formatter = DateFormatter()
			formatter.dateStyle = .long
			releaseDateLabel.text = formatter.string(from: date)
		} else {
			releaseDateLabel.text = nil
		}
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
		backgroundImageView.image = movie?.backdrop
		if movie?.backdrop == nil, let path = movie?.backdropPath {
			manager.backdrop(
				forPath: path,
				success: { (image) in
					movie?.backdrop = image
					self.backgroundImageView.image = image
			}, failure: { (error) in
				print(error)
			})
		}
	}
}
