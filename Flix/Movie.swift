//
//  Movie.swift
//  Flix
//
//  Created by Nathan Ansel on 7/30/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import Foundation

struct Movie: Codable {
	var id: Int
	var title: String
	var overview: String
}

extension Movie: Searchable {
	func performSearch(with query: Query) -> SearchResult {
		let searchText = "\(title.lowercased()) \(overview.lowercased())"
		var searchResult = SearchResult(numberOfKeywordMatches: 0)
		for keyword in query.keywords {
			if searchText.contains(keyword) {
				searchResult.numberOfKeywordMatches += 1
			}
		}
		return searchResult
	}
}
