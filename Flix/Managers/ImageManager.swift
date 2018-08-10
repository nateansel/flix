//
//  ImageManager.swift
//  Flix
//
//  Created by Nathan Ansel on 8/3/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class ImageManager {
	private enum Locations {
		static let base = "https://image.tmdb.org/t/p"
		static func smallPoster(withPath path: String) -> String { return base + "/w185" + path }
		static func backdrop(withPath path: String) -> String { return base + "/w780" + path }
	}
	
	private enum Security {
		static let apiKeyName = "api_key"
		static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
	}
	
	private var isLoadingPaths: [String] = []
	
	static var shared = ImageManager()
	
	typealias ImageSuccess = (UIImage) -> Void
	typealias ImageFailure = (Error) -> Void
	func smallPoster(forPath path: String, success: @escaping ImageSuccess, failure: @escaping ImageFailure) {
		guard !isLoadingPaths.contains(path) else {
			return
		}
		isLoadingPaths.append(path)
		
		var components = URLComponents(string: Locations.smallPoster(withPath: path))
		components?.queryItems = [
			URLQueryItem(name: Security.apiKeyName, value: Security.apiKey)
		]
		guard let url = components?.url else {
			fatalError("Invalid Poster url for path: \(path)")
		}
		let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
		let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
		let task = session.dataTask(with: request) { (data, response, error) in
			if let index = self.isLoadingPaths.index(of: path) {
				self.isLoadingPaths.remove(at: index)
			}
			guard error == nil else {
				// Inform the UI about any errors
				failure(error!)
				return
			}
			guard let data = data, !data.isEmpty else {
				// TODO: Inform the UI about incorrect data
				return
			}
			if let image = UIImage(data: data) {
				success(image)
			} else {
				print(String.init(data: data, encoding: .utf8))
				// TODO: Inform the UI about the image not working
			}
		}
		task.resume()
	}
	
	func backdrop(forPath path: String, success: @escaping ImageSuccess, failure: @escaping ImageFailure) {
		guard !isLoadingPaths.contains(path) else {
			return
		}
		isLoadingPaths.append(path)
		
		var components = URLComponents(string: Locations.backdrop(withPath: path))
		components?.queryItems = [
			URLQueryItem(name: Security.apiKeyName, value: Security.apiKey)
		]
		guard let url = components?.url else {
			fatalError("Invalid Backdrop url for path: \(path)")
		}
		let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
		let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
		let task = session.dataTask(with: request) { (data, response, error) in
			if let index = self.isLoadingPaths.index(of: path) {
				self.isLoadingPaths.remove(at: index)
			}
			guard error == nil else {
				// Inform the UI about any errors
				failure(error!)
				return
			}
			guard let data = data, !data.isEmpty else {
				// TODO: Inform the UI about incorrect data
				return
			}
			if let image = UIImage(data: data) {
				success(image)
			} else {
				print(String.init(data: data, encoding: .utf8))
				// TODO: Inform the UI about the image not working
			}
		}
		task.resume()
	}
}
