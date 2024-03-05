//
//  NetworkManager.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation
import DTLogger

protocol INetworkManager {
	func getWeatherFor(city: String, completion: @escaping (Result<APIWeatherResponse, NetworkError>) -> Void)
}

final class NetworkManager {
	// MARK: - Dependencies
	
	private let requestService: IRequestSender
	private let logger: DTLogger
	
	// MARK: - Initializer
	
	init(
		requestService: IRequestSender,
		logger: DTLogger
	) {
		self.requestService = requestService
		self.logger = logger
	}
}

// MARK: - INetworkManager

extension NetworkManager: INetworkManager {
	func getWeatherFor(city: String, completion: @escaping (Result<APIWeatherResponse, NetworkError>) -> Void) {
		let requestConfig = RequestFactory.WeatherDataRequest.weatherModelConfig(for: city, language: .ru)
		
		requestService.send(config: requestConfig) { result in
			switch result {
			case .success(let (model, _, _)):
				guard let model else {
					completion(.failure(.notFound))
					return
				}
				completion(.success(model))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
