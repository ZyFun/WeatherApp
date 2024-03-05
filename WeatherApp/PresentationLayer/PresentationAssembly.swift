//
//  PresentationAssembly.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation

final class PresentationAssembly {
	private var service = ServiceAssembly()
	
	// FIXME: Пока не стал разделять зависимости, но знаю что это место не для неё
	private lazy var networkManager: INetworkManager = NetworkManager(
		requestService: service.requestService,
		logger: service.logger
	)
	
	lazy var weatherScreen: WeatherScreenConfigurator = {
		return WeatherScreenConfigurator(networkManager: networkManager)
	}()
}
