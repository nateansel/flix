//
//  MovieManager.swift
//  Flix
//
//  Created by Nathan Ansel on 7/30/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import Foundation

struct NowPlayingListResults: Codable {
	struct Dates: Codable {
		var maximum: Date
		var minimum: Date
	}
	
	var page: Int
	var results: [Movie]
	var dates: Dates
	var totalPages: Int
	var totalResults: Int
	
	enum CodingKeys: String, CodingKey {
		case page, results, dates
		case totalPages = "total_pages"
		case totalResults = "total_results"
	}
}

class MovieManager {
	private enum Locations {
		static let base = "https://api.themoviedb.org/3"
		static let nowPlaying = base + "/movie/now_playing"
		static func details(forMovieWithID id: String) -> String { return base + "/movie/\(id)" }
	}
	
	private enum Security {
		static let apiKeyName = "apiKey"
		static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
	}
	
	let shared = MovieManager()
	
	typealias NowPlayingListSucces = (NowPlayingListResults) -> Void
	typealias NowPlayingListFailure = (Error) -> Void
	func nowPlayingList(success: @escaping NowPlayingListSucces, failure: @escaping NowPlayingListFailure) {
		var components = URLComponents(string: Locations.nowPlaying)
		components?.queryItems = [
			URLQueryItem(name: Security.apiKeyName, value: Security.apiKey)
		]
		guard let url = components?.url else {
			fatalError("Invalid Now Playing list url: \(Locations.nowPlaying)")
		}
		let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
		let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
		let task = session.dataTask(with: request) { (data, response, error) in
			guard error == nil else {
				// Inform the UI about any errors
				failure(error!)
				return
			}
			guard let data = data else {
				// TODO: Inform the UI about incorrect data
				return
			}
			
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			do {
				let results = try decoder.decode(NowPlayingListResults.self, from: data)
				success(results)
			} catch {
				failure(error)
			}
		}
		task.resume()
	}
}
