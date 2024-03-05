//
//  WeatherRequest.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation
import DTLogger

struct WeatherRequest: IRequest {
	var urlRequest: URLRequest?
	var urlString: String
	
	init(urlString: String) {
		self.urlString = urlString
		urlRequest = request(stringURL: urlString)
	}
	
	mutating func request(stringURL: String) -> URLRequest? {
		if let url = URL(string: stringURL) {
			urlRequest = URLRequest(url: url, timeoutInterval: 30)
		} else {
			DTLogger.shared.log(.error, "Неправильный URL")
		}
		return urlRequest
	}
}
