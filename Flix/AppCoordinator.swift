//
//  AppCoordinator.swift
//  Flix
//
//  Created by Nathan Ansel on 8/9/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class AppCoordinator {
	var tabBarController: UITabBarController
	
	let nowPlayingCoordinator: NowPlayingCoordinator
	let topRatedCoordinator: TopRatedCoordinator
	
	init(tabBarController: UITabBarController) {
		self.tabBarController = tabBarController
		nowPlayingCoordinator = NowPlayingCoordinator(navigationController: UINavigationController())
		nowPlayingCoordinator.navigationController.navigationBar.prefersLargeTitles = true
		
		topRatedCoordinator = TopRatedCoordinator(navigationController: UINavigationController())
		topRatedCoordinator.navigationController.navigationBar.prefersLargeTitles = true
		
		tabBarController.setViewControllers([
				nowPlayingCoordinator.navigationController,
				topRatedCoordinator.navigationController
			], animated: false)
	}
	
	func start() {
		nowPlayingCoordinator.start()
		topRatedCoordinator.start()
	}
}
