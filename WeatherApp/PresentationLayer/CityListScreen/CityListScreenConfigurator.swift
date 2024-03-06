//
//  CityListScreenConfigurator.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 06.03.2024.
//

import UIKit

final class CityListScreenConfigurator {
	func config(
		view: UIViewController
	) {
		guard let view = view as? CityListScreenViewController else { return }
		let presenter = CityListScreenPresenter(view: view)
		
		view.presenter = presenter
		presenter.view = view
	}
}
