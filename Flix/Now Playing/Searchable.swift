//
//  Searchable.swift
//  Flix
//
//  Created by Nathan Ansel on 8/2/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import Foundation

struct Query {
	var keywords: [String]
	
	init(searchText: String) {
		keywords = searchText.lowercased().components(separatedBy: .whitespaces)
	}
}

struct SearchResult {
	var numberOfKeywordMatches: Int
}

protocol Searchable {
	func performSearch(with query: Query) -> SearchResult
}

extension Collection where Element: Searchable {
	func search(for searchText: String) -> [Element] {
		let query = Query(searchText: searchText)
		return self
			.map { (element: $0, searchResult: $0.performSearch(with: query)) }
			.filter { $0.searchResult.numberOfKeywordMatches > 0 }
			.sorted { $0.searchResult.numberOfKeywordMatches > $1.searchResult.numberOfKeywordMatches }
			.map { $0.element }
	}
}
