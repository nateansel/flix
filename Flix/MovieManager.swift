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
}

class MovieManager {
	private enum Locations {
		static let base = "https://api.themoviedb.org/3"
		static let nowPlaying = base + "/movie/now_playing"
		static func details(forMovieWithID id: String) -> String { return base + "/movie/\(id)" }
	}
	
	private enum Security {
		static let apiKeyName = "api_key"
		static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
	}
	
	static let shared = MovieManager()
	
	typealias NowPlayingListSucces = (NowPlayingListResults) -> Void
	typealias NowPlayingListFailure = (Error) -> Void
	func nowPlayingList(page: Int? = nil, success: @escaping NowPlayingListSucces, failure: @escaping NowPlayingListFailure) {
		var components = URLComponents(string: Locations.nowPlaying)
		components?.queryItems = [
			URLQueryItem(name: Security.apiKeyName, value: Security.apiKey)
		]
		if let page = page {
			components?.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
		}
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
			guard let data = data, !data.isEmpty else {
				// TODO: Inform the UI about incorrect data
				return
			}
			
			let decoder = JSONDecoder()
			let formatter = DateFormatter()
			formatter.dateFormat = "YYYY-MM-dd"
			decoder.dateDecodingStrategy = .formatted(formatter)
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			do {
				let results = try decoder.decode(NowPlayingListResults.self, from: data)
				success(results)
			} catch {
				print(error)
				failure(error)
			}
		}
		task.resume()
	}
}
