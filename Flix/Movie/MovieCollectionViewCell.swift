//
//  MovieCollectionViewCell.swift
//  Flix
//
//  Created by Nathan Ansel on 8/9/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

extension Cell {
	static let movieCollection: ReusableCell<MovieCollectionViewCell> = {
		let string = String(describing: MovieCollectionViewCell.self)
		return ReusableCell(identifier: string)
	}()
}

class MovieCollectionViewCell: UICollectionViewCell {
	private let posterImageView = UIImageView()
	
	var manager = ImageManager.shared
	
	var movie: Movie? {
		didSet {
			posterImageView.image = movie?.poster ?? #imageLiteral(resourceName: "default_poster")
			if movie?.poster == nil, let path = movie?.posterPath {
				manager.smallPoster(
					forPath: path,
					success: { [unowned self] (image) in
						if self.movie?.posterPath == path {
							self.movie?.poster = image
							self.posterImageView.image = image
						}
					}, failure: { (error) in })
			}
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		contentView.prepareViewForConstraints(posterImageView)
		NSLayoutConstraint.activate([
			posterImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			posterImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			posterImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
			posterImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
		])
		posterImageView.image = #imageLiteral(resourceName: "default_poster")
	}
}
