//
//  TopRatedViewController.swift
//  Flix
//
//  Created by Nathan Ansel on 8/9/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class TopRatedViewController: UIViewController {
	
	var movieView: MovieListCollectionView { return view as! MovieListCollectionView }
	
	var manager = MovieManager.shared
	var delegate: NowPlayingViewControllerDelegate?
	
	override func loadView() {
		view = MovieListCollectionView()
		movieView.delegate = self
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Top Rated"
		movieView.beginRefreshing()
		didBeginRefreshing()
	}
}

extension TopRatedViewController: MovieListViewDelegate {
	func didBeginRefreshing() {
		manager.topRatedList(
			success: { (results) in
				self.movieView.endRefreshing()
				self.movieView.update(with: results.results)
			}, failure: { (error) in
				self.movieView.endRefreshing()
				print(error)
		})
	}
	
	func didEndRefreshing() {}
	
	func loadingCellDisplayed() {}
	
	func didSelect(movie: Movie) {
		delegate?.openDetails(for: movie)
	}
}
