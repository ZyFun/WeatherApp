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
		let requestConfig = RequestFactory.WeatherDataRequest.weatherModelConfig(for: city)
		
		requestService.send(config: requestConfig) { [weak self] result in
			switch result {
			case .success(let (model, _, _)):
				DispatchQueue.main.async {
					print(model?.name ?? "lol")
				}
			case .failure(let error):
				self?.logger.log(.error, error.localizedDescription)
			}
		}
	}
}
