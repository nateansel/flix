//
//  TopRatedCoordinator.swift
//  Flix
//
//  Created by Nathan Ansel on 8/9/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class TopRatedCoordinator {
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
	}
	
	func start() {
		let vc = TopRatedViewController()
		vc.delegate = self
		navigationController.pushViewController(vc, animated: true)
	}
}

extension TopRatedCoordinator: NowPlayingViewControllerDelegate {
	func openDetails(for movie: Movie) {
		let vc = MovieDetailsViewController()
		vc.movie = movie
		navigationController.pushViewController(vc, animated: true)
	}
}
