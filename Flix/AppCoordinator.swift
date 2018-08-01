//
//  AppCoordinator.swift
//  Flix
//
//  Created by Nathan Ansel on 7/31/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class AppCoordinator {
	let navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let vc = NowPlayingViewController()
		vc.delegate = self
		vc.manager = MovieManager.shared
		navigationController.pushViewController(vc, animated: false)
	}
}

extension AppCoordinator: NowPlayingViewControllerDelegate {
	func openDetails(for movie: Movie) {
		
	}
}
