//
//  Movie.swift
//  Flix
//
//  Created by Nathan Ansel on 7/30/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class Movie: Codable {
	var id: Int
	var title: String
	var overview: String
	var releaseDate: Date
	var posterPath: String?
	var backdropPath: String?
	
	var poster: UIImage?
	var backdrop: UIImage?
	
	enum CodingKeys: String, CodingKey {
		case id, title, overview, releaseDate, posterPath, backdropPath
	}
	
    init(id: Int, title: String, overview: String, releaseDate: Date, posterPath: String?, backdropPath: String?) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.releaseDate = releaseDate
    }
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
