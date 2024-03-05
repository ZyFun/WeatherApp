//
//  WeatherScreenConfigurator.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import UIKit

final class WeatherScreenConfigurator {
	private let networkManager: INetworkManager
	
	init(networkManager: INetworkManager) {
		self.networkManager = networkManager
	}
	
	func config(
		view: UIViewController,
		navigationController: UINavigationController
	) {
		guard let view = view as? WeatherScreenViewController else { return }
		let presenter = WeatherScreenPresenter(view: view)
		let dataSourceProvider: IWeatherScreenDataSourceProvider = WeatherScreenDataSourceProvider()
		let router = WeatherScreenRouter(withNavigationController: navigationController)
		
		view.presenter = presenter
		view.dataSourceProvider = dataSourceProvider
		presenter.view = view
		presenter.router = router
		
		presenter.networkManager = networkManager
	}
}
