//
//  ConfigurationManager.swift
//  Flix
//
//  Created by Nathan Ansel on 8/3/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import Foundation

struct ConfigurationResults: Codable {
	struct Images: Codable {
		var baseUrl: String
		var secureBaseUrl: String
		var backdropSizes: [String]
		var logoSizes: [String]
		var posterSizes: [String]
		var profileSizes: [String]
		var stillSizes: [String]
	}
	
	var images: Images
	var changeKeys: [String]
}

class ConfigurationManager {
	private enum Locations {
		static let base = "https://api.themoviedb.org/3"
		static let configuration = base + "/configuration"
	}
	
	private enum Security {
		static let apiKeyName = "api_key"
		static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
	}
	
	typealias ConfigurationSuccess = () -> Void
	typealias ConfigurationFailure = (Error) -> Void
	func configuration(success: @escaping ConfigurationSuccess, failure: @escaping ConfigurationFailure) {
		var components = URLComponents(string: Locations.configuration)
		components?.queryItems = [
			URLQueryItem(name: Security.apiKeyName, value: Security.apiKey)
		]
		guard let url = components?.url else {
			fatalError("Invalid Configuration url: \(Locations.configuration)")
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
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			do {
				
				success()
			} catch {
				print(error)
				failure(error)
			}
		}
		task.resume()
	}
}
