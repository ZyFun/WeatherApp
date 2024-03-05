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
//		case <# targetModule #>
	}
	
	func routeTo(target: WeatherScreenRouter.Targets) {
//		switch target {
//		case <# targetModule #>:
//			let <# targetModule #>VC = <#moduleName#>ViewController()
//			
//			// Configure MVP
//			PresentationAssembly().<#moduleName#>.config(
//				view: medicineVC,
//				navigationController: navigationController
//			)
//			
//			// Navigation
//			navigationController?.pushViewController(<# targetModule #>VC, animated: true)
//		}
	}
}
