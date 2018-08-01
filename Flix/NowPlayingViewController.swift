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
	
	override func loadView() {
		view = MovieListView()
		movieView.delegate = self
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Now Playing"
	}
}

extension NowPlayingViewController: MovieListViewDelegate {
	func didBeginRefreshing() {
		manager?.nowPlayingList(
			success: { [unowned self] (results) in
				self.movieView.endRefreshing()
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
