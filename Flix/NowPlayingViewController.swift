//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Nathan Ansel on 7/31/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

protocol NowPlayingViewControllerDelegate: class {
	func openDetails(for movie: Movie)
}

class NowPlayingViewController: UIViewController {
	
	var manager: MovieManager?
	var delegate: NowPlayingViewControllerDelegate?
	
	var movieView: MovieListView { return view as! MovieListView }
	var searchController = UISearchController(searchResultsController: nil)
	
	private var fullMovies: [Movie] = []
	
	override func loadView() {
		view = MovieListView()
		movieView.delegate = self
		searchController.dimsBackgroundDuringPresentation = false
		searchController.searchResultsUpdater = self
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Now Playing"
		
		navigationItem.searchController = searchController
	}
}

extension NowPlayingViewController: MovieListViewDelegate {
	func didBeginRefreshing() {
		manager?.nowPlayingList(
			success: { [unowned self] (results) in
				self.movieView.endRefreshing()
				self.fullMovies = results.results
				self.movieView.update(with: results.results)
			}, failure: { [unowned self] (error) in
				self.movieView.endRefreshing()
				print(error)
				// TODO: Display error message
		})
	}
	
	func didEndRefreshing() {}
	
	func didSelect(movie: Movie) {
		delegate?.openDetails(for: movie)
	}
}

extension NowPlayingViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		if let searchText = searchController.searchBar.text, !searchText.isEmpty {
			let filteredMovies = fullMovies.search(for: searchText)
			movieView.update(with: filteredMovies)
		} else {
			movieView.update(with: fullMovies)
		}
	}
}
