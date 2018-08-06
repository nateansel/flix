//
//  LoadingTableViewCell.swift
//  Flix
//
//  Created by Nathan Ansel on 8/3/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

extension Cell {
	static let loading: ReusableCell<LoadingTableViewCell> = {
		let string = String(describing: LoadingTableViewCell.self)
		return ReusableCell(identifier: string)
	}()
}

class LoadingTableViewCell: UITableViewCell {
	private let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
	
	var isLoading: Bool {
		set {
			if newValue {
				activityView.startAnimating()
			} else {
				activityView.stopAnimating()
			}
		}
		get { return activityView.isAnimating }
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}
	
	private func commonInit() {
		contentView.prepareViewForConstraints(activityView)
		NSLayoutConstraint.activate([
			activityView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
			activityView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
			activityView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
			activityView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
		])
		activityView.color = .darkGray
		activityView.hidesWhenStopped = false
	}
}
