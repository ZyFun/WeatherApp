//
//  CityListScreenRouter.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 06.03.2024.
//

import UIKit

protocol CityListScreenRoutingLogic {
	func routeTo(target: CityListScreenRouter.Targets)
}

final class CityListScreenRouter: CityListScreenRoutingLogic {
	
	private var navigationController: UINavigationController
	
	init(withNavigationController: UINavigationController) {
		navigationController = withNavigationController
	}
	
	enum Targets {
		case closeScreen
	}
	
	func routeTo(target: CityListScreenRouter.Targets) {
		switch target {
		case .closeScreen:
			navigationController.popViewController(animated: true)
		}
	}
}
