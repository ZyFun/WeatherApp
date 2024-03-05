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
		let router = WeatherScreenRouter(withNavigationController: navigationController)
		
		view.presenter = presenter
		presenter.view = view
		presenter.router = router
		
		presenter.networkManager = networkManager
	}
}
