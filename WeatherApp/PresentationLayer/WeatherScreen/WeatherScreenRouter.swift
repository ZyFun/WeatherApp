//
//  WeatherScreenRouter.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import UIKit

protocol WeatherScreenRoutingLogic {
	func routeTo(target: WeatherScreenRouter.Targets)
}

final class WeatherScreenRouter: WeatherScreenRoutingLogic {
	
	private var navigationController: UINavigationController
	
	init(withNavigationController: UINavigationController) {
		navigationController = withNavigationController
	}
	
	enum Targets {
		case cityListScreen
	}
	
	func routeTo(target: WeatherScreenRouter.Targets) {
		switch target {
		case .cityListScreen:
			let cityListScreenVC = CityListScreenViewController()
			
			// Configure MVP
			PresentationAssembly().cityListScreen.config(
				view: cityListScreenVC
			)
			
			// Navigation
			navigationController.pushViewController(cityListScreenVC, animated: true)
		}
	}
}
