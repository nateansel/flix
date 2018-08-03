//
//  MovieListView.swift
//  Flix
//
//  Created by Nathan Ansel on 7/31/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

// MARK: - MovieListViewDelegate

protocol MovieListViewDelegate: class {
	func didBeginRefreshing()
	func didEndRefreshing()
	func loadingCellDisplayed()
	func didSelect(movie: Movie)
}

// MARK: - MovieListView

class MovieListView: UIView {
	
	// MARK: Properties
	
	private static let movieSection = 0
	private static let loadingSection = 1
	
	private let tableView = UITableView()
	private let refreshControl = UIRefreshControl()
	private var canLoadMore = false
	
	var movies: [Movie] = []
	var allowsPullToRefresh = true {
		didSet {
			if allowsPullToRefresh {
				tableView.refreshControl = refreshControl
			} else {
				tableView.refreshControl = nil
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
		prepareViewForConstraints(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: topAnchor),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
		
		tableView.registerReusableCell(Cell.movie)
		tableView.registerReusableCell(Cell.loading)
		tableView.refreshControl = refreshControl
		tableView.dataSource = self
		tableView.delegate = self
		tableView.estimatedRowHeight = 136
		
		refreshControl.addTarget(self, action: #selector(refreshControlActivated), for: .valueChanged)
	}
	
	func beginRefreshing() {
		refreshControl.beginRefreshing()
	}
	
	func endRefreshing() {
		refreshControl.endRefreshing()
	}
	
	func deselect(movie: Movie, animated: Bool = true) {
		if let index = movies.index(where: { $0.id == movie.id }) {
			tableView.deselectRow(at: IndexPath(row: index, section: 0), animated: animated)
		}
	}
	
	func update(with movies: [Movie]) {
		self.movies = movies
		canLoadMore = allowsEndlessScroll
		tableView.reloadData()
	}
	
	func updateByAppending(with movies: [Movie], isEndOfList: Bool) {
		let currentCount = self.movies.count
		let indexPaths = movies.enumerated().map { IndexPath(row: currentCount + $0.offset, section: 0) }
		self.movies.append(contentsOf: movies)
		canLoadMore = !isEndOfList
		tableView.beginUpdates()
		if isEndOfList {
			tableView.deleteSections([MovieListView.loadingSection], with: .none)
		}
		tableView.insertRows(at: indexPaths, with: .top)
		tableView.endUpdates()
	}
	
	@objc
	private func refreshControlActivated() {
		delegate?.didBeginRefreshing()
	}
}

// MARK: - UITableViewDataSource

extension MovieListView: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		if canLoadMore {
			return 2
		}
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case MovieListView.movieSection: return movies.count
		case MovieListView.loadingSection: return 1
		default: fatalError("Too many sections in Movie List View")
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch indexPath.section {
		case MovieListView.movieSection:
			let movie = movies[indexPath.row]
			let cell = tableView.dequeueCell(Cell.movie, forIndexPath: indexPath)
			cell.title = movie.title
			cell.overview = movie.overview
			return cell
		case MovieListView.loadingSection:
			let cell = tableView.dequeueCell(Cell.loading, forIndexPath: indexPath)
			cell.isLoading = true
			return cell
		default:
			fatalError("Invalid section. Unable to create UITableViewCell for: \(indexPath)")
		}
	}
}

// MARK: - UITableViewDelegate

extension MovieListView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.didSelect(movie: movies[indexPath.row])
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.section == MovieListView.loadingSection {
			delegate?.loadingCellDisplayed()
		}
	}
}
