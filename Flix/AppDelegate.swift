//
//  AppDelegate.swift
//  flix
//
//  Created by Nathan Ansel on 7/30/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	let appCoordinator = AppCoordinator(tabBarController: UITabBarController())

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
//		appCoordinator.navigationController.navigationBar.barStyle = .blackTranslucent
//		appCoordinator.navigationController.navigationBar.prefersLargeTitles = true
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = appCoordinator.tabBarController
		window?.makeKeyAndVisible()
		
		appCoordinator.start()
		
		return true
	}
}

