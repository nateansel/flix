//
//  MovieListView.swift
//  Flix
//
//  Created by Nathan Ansel on 7/31/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

protocol MovieListViewDelegate: class {
	func didBeginRefreshing()
	func didEndRefreshing()
	func didSelect(movie: Movie)
}

class MovieListView: UIView {
	private let tableView = UITableView()
	private let refreshControl = UIRefreshControl()
	
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
	
	var delegate: MovieListViewDelegate?
	
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
		tableView.refreshControl = refreshControl
		tableView.dataSource = self
		
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
		tableView.reloadData()
	}
	
	@objc
	private func refreshControlActivated() {
		delegate?.didBeginRefreshing()
	}
}

extension MovieListView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return movies.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let movie = movies[indexPath.row]
		let cell = tableView.dequeueCell(Cell.movie, forIndexPath: indexPath)
		cell.title = movie.title
		cell.overview = movie.overview
		return cell
	}
}

extension MovieListView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.didSelect(movie: movies[indexPath.row])
	}
}
