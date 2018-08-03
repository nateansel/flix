//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Nathan Ansel on 8/3/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
	
	let movieView = MovieDetailsView()
	
	var movie: Movie? {
		didSet {
			movieView.updateInterface(with: movie)
		}
	}
	
	override func loadView() {
		let view = UIView()
		let scrollView = UIScrollView()
		view.prepareViewForConstraints(scrollView)
		scrollView.prepareViewForConstraints(movieView)
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			
			movieView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			movieView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			movieView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			movieView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			movieView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
		])
		view.backgroundColor = .black
		self.view = view
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.largeTitleDisplayMode = .never
		title = "Details"
	}
}
