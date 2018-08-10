//
//  MovieListCollectionView.swift
//  Flix
//
//  Created by Nathan Ansel on 8/9/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class MovieListCollectionView: UIView {
	
	// MARK: Properties
	
	private static let movieSection = 0
	private static let loadingSection = 1
	
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		return UICollectionView(frame: .zero, collectionViewLayout: layout)
	}()
	private let refreshControl = UIRefreshControl()
	private var canLoadMore = false
	
	var movies: [Movie] = []
	var allowsPullToRefresh = true {
		didSet {
			if allowsPullToRefresh {
				collectionView.refreshControl = refreshControl
			} else {
				collectionView.refreshControl = nil
			}
		}
	}
	var allowsEndlessScroll = false {
		didSet {
			canLoadMore = allowsEndlessScroll
		}
	}
	
	var delegate: MovieListViewDelegate?
	
	// MARK: Methods
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		prepareViewForConstraints(collectionView)
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
		
		collectionView.registerReusableCell(Cell.movieCollection)
		collectionView.refreshControl = refreshControl
		collectionView.dataSource = self
		collectionView.delegate = self
		
		refreshControl.addTarget(self, action: #selector(refreshControlActivated), for: .valueChanged)
		collectionView.backgroundColor = .white
	}
	
	func beginRefreshing() {
		refreshControl.beginRefreshing()
	}
	
	func endRefreshing() {
		refreshControl.endRefreshing()
	}
	
	func deselect(movie: Movie, animated: Bool = true) {
		if let index = movies.index(where: { $0.id == movie.id }) {
//			collectionView.deselectRow(at: IndexPath(row: index, section: 0), animated: animated)
		}
	}
	
	func update(with movies: [Movie]) {
		self.movies = movies
		canLoadMore = allowsEndlessScroll
		collectionView.reloadData()
	}
	
	func updateByAppending(with movies: [Movie], isEndOfList: Bool) {
		let currentCount = self.movies.count
		let indexPaths = movies.enumerated().map { IndexPath(row: currentCount + $0.offset, section: 0) }
		self.movies.append(contentsOf: movies)
		canLoadMore = !isEndOfList
		collectionView.insertItems(at: indexPaths)
	}
	
	@objc
	private func refreshControlActivated() {
		delegate?.didBeginRefreshing()
	}
}

// MARK: - UITableViewDataSource

extension MovieListCollectionView: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch section {
		case MovieListCollectionView.movieSection: return movies.count
		case MovieListCollectionView.loadingSection: return 1
		default: fatalError("Too many sections in Movie Collection View")
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch indexPath.section {
		case 0:
			let cell = collectionView.dequeueCell(Cell.movieCollection, forIndexPath: indexPath)
			cell.movie = movies[indexPath.row]
			return cell
		default:
			fatalError()
		}
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
//		if canLoadMore {
//			return 2
//		}
		return 1
	}
}

// MARK: - UITableViewDelegate

extension MovieListCollectionView: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegate?.didSelect(movie: movies[indexPath.row])
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		if indexPath.section == MovieListCollectionView.loadingSection {
			delegate?.loadingCellDisplayed()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (collectionView.frame.width - 8) / 2
		return CGSize(width: width, height: (width * 3) / 2)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .zero
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
}
