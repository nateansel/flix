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
	private var detailsMovie: Movie?
	private var currentPage = 0
	private var isLoading = false
	
	override func loadView() {
		view = MovieListView()
		movieView.delegate = self
		movieView.allowsEndlessScroll = true
		searchController.dimsBackgroundDuringPresentation = false
		searchController.searchResultsUpdater = self
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Now Playing"
		
		navigationItem.searchController = searchController
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if let movie = detailsMovie {
			movieView.deselect(movie: movie, animated: animated)
		}
	}
}

extension NowPlayingViewController: MovieListViewDelegate {
	func didBeginRefreshing() {
		if !isLoading {
			isLoading = true
			manager?.nowPlayingList(
				success: { [unowned self] (results) in
					self.isLoading = false
					self.currentPage = results.page
					self.movieView.endRefreshing()
					self.fullMovies = results.results
					self.movieView.update(with: results.results)
				}, failure: { [unowned self] (error) in
					self.isLoading = false
					self.movieView.endRefreshing()
					print(error)
					// TODO: Display error message
			})
		}
	}
	
	func didEndRefreshing() {}
	
	func loadingCellDisplayed() {
		if !isLoading {
			isLoading = true
			manager?.nowPlayingList(
				page: currentPage.advanced(by: 1),
				success: { [unowned self] (results) in
					self.isLoading = false
					self.currentPage = results.page
					self.movieView.endRefreshing()
					self.fullMovies = results.results
					self.movieView.updateByAppending(with: results.results, isEndOfList: results.page == results.totalPages)
				}, failure: { [unowned self] (error) in
					self.isLoading = false
					self.movieView.endRefreshing()
					print(error)
					// TODO: Display error message
			})
		}
	}
	
	func didSelect(movie: Movie) {
		detailsMovie = movie
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
