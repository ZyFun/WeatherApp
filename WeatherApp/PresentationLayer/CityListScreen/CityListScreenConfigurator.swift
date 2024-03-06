//
//  CityListScreenConfigurator.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 06.03.2024.
//

import UIKit
import DTLogger

final class CityListScreenConfigurator {
	private let userDefaultsService: IUserDefaultsStorageService
	private let coreDataService: ICoreDataStorageService
	private let logger: DTLogger
	
	init(
		userDefaultsService: IUserDefaultsStorageService,
		coreDataService: ICoreDataStorageService,
		logger: DTLogger
	) {
		self.userDefaultsService = userDefaultsService
		self.coreDataService = coreDataService
		self.logger = logger
	}
	
	func config(
		view: UIViewController,
		navigationController: UINavigationController
	) {
		guard let view = view as? CityListScreenViewController else { return }
		let presenter = CityListScreenPresenter(view: view)
		let router = CityListScreenRouter(withNavigationController: navigationController)
		let fetchedResultManager = CitiesFetchedResultsManager(
			fetchedResultsController: coreDataService.fetchResultController(
				entityName: String(describing: DBCity.self),
				keyForSort: #keyPath(DBCity.name),
				sortAscending: true
			),
			logger: logger
		)
		
		let dataSourceProvider = CityListScreenDataSourceProvider(
			presenter: presenter,
			resultManager: fetchedResultManager,
			logger: logger
		)
		
		view.presenter = presenter
		view.dataSourceProvider = dataSourceProvider
		view.fetchedResultManager = fetchedResultManager
		presenter.view = view
		presenter.router = router
		presenter.logger = logger
		presenter.userDefaultsService = userDefaultsService
		presenter.coreDataService = coreDataService
	}
}
