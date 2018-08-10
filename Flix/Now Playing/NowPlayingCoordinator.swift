//
//  NowPlayingCoordinator.swift
//  Flix
//
//  Created by Nathan Ansel on 7/31/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class NowPlayingCoordinator {
	let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
		self.navigationController.tabBarItem = UITabBarItem(title: "Now Playing", image: #imageLiteral(resourceName: "ticket"), tag: 0)
	}
	
	func start() {
		let vc = NowPlayingViewController()
		vc.delegate = self
		vc.manager = MovieManager.shared
		navigationController.pushViewController(vc, animated: false)
	}
}

extension NowPlayingCoordinator: NowPlayingViewControllerDelegate {
	func openDetails(for movie: Movie) {
		let vc = MovieDetailsViewController()
		vc.movie = movie
		navigationController.pushViewController(vc, animated: true)
	}
}
