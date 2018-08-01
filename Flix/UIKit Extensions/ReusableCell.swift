//
//  ReusableCell.swift
//  myMDHS
//
//  Created by Nathan Ansel on 6/7/18.
//  Copyright © 2018 nSPARC. All rights reserved.
//

import UIKit

public enum Cell {}

public enum ReusableCell<Cell> {
	case Class(identifier: String)
	case Nib(identifier: String, nibName: String)
	
	public var identifier: String {
		switch self {
		case .Class(let identifier): return identifier
		case .Nib(let identifier, _): return identifier
		}
	}
	
	public init(identifier: String) {
		self = .Class(identifier: identifier)
	}
	
	public init(identifier: String, nibName: String) {
		self = .Nib(identifier: identifier, nibName: nibName)
	}
	
	public init(nibName: String) {
		self = .Nib(identifier: nibName, nibName: nibName)
	}
}

public enum ReusableHeaderFooterView<HeaderFooter> {
	case Class(identifier: String)
	
	public var identifier: String {
		switch self {
		case .Class(let identifier): return identifier
		}
	}
	
	public init(identifier: String) {
		self = .Class(identifier: identifier)
	}
}

public extension UITableView {
	final func registerReusableCell<T>(_ cell: ReusableCell<T>) where T: UITableViewCell {
		switch cell {
		case .Class(let identifier):
			register(T.self, forCellReuseIdentifier: identifier)
		case .Nib(let identifier, let nibName):
			let nib = UINib(nibName: nibName, bundle: Bundle(for: T.self))
			register(nib, forCellReuseIdentifier: identifier)
		}
	}
	
	final func dequeueCell<T>(_ cell: ReusableCell<T>, forIndexPath indexPath: IndexPath) -> T where T: UITableViewCell {
		return dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! T
	}
	
	final func registerReusableHeaderFooterView<T>(_ cell: ReusableHeaderFooterView<T>) where T: UITableViewHeaderFooterView {
		switch cell {
		case .Class(let identifier):
			register(T.self, forHeaderFooterViewReuseIdentifier: identifier)
		}
	}
	
	final func dequeueHeaderFooter<T>(_ view: ReusableHeaderFooterView<T>) -> T where T: UITableViewHeaderFooterView {
		return dequeueReusableHeaderFooterView(withIdentifier: view.identifier) as! T
	}
}

public extension UICollectionView {
	final func registerReusableCell<T>(_ cell: ReusableCell<T>) where T: UICollectionViewCell {
		switch cell {
		case .Class(let identifier):
			register(T.self, forCellWithReuseIdentifier: identifier)
		case .Nib(let identifier, let nibName):
			let nib = UINib(nibName: nibName, bundle: Bundle.main)
			register(nib, forCellWithReuseIdentifier: identifier)
		}
	}
	
	final func dequeueCell<T>(_ cell: ReusableCell<T>, forIndexPath indexPath: IndexPath) -> T where T: UICollectionViewCell {
		return dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as! T
	}
	
	final func registerReusableSuplementaryView<T>(_ cell: ReusableCell<T>) where T: UICollectionReusableView {
		switch cell {
		case .Class(let identifier):
			register(T.self, forSupplementaryViewOfKind: String(describing: T.self), withReuseIdentifier: identifier)
		case .Nib(let identifier, let nibName):
			let nib = UINib(nibName: nibName, bundle: Bundle.main)
			register(nib, forSupplementaryViewOfKind: String(describing: T.self), withReuseIdentifier: identifier)
		}
	}
	
	final func dequeueReusableSupplementaryView<T>(_ cell: ReusableCell<T>, forIndexPath indexPath: IndexPath) -> T where T: UICollectionReusableView {
		return dequeueReusableSupplementaryView(ofKind: String(describing: T.self), withReuseIdentifier: cell.identifier, for: indexPath) as! T
	}
}
