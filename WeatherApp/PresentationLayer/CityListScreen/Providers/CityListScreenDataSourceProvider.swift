//
//  CityListScreenDataSourceProvider.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 06.03.2024.
//

import UIKit
import DTLogger

protocol ICityListScreenDataSourceProvider: UITableViewDelegate, UITableViewDataSource {
	var fetchedResultManager: ICitiesFetchedResultsManager { get set }
}

final class CityListScreenDataSourceProvider: NSObject, ICityListScreenDataSourceProvider {
	
	// MARK: - Public Properties
	
	var fetchedResultManager: ICitiesFetchedResultsManager
	
	// MARK: - Private properties
	
	private let presenter: CityListScreenPresenter?
	
	// MARK: - Dependencies
	
	private let logger: DTLogger
	
	// MARK: - Initializer
	
	init(
		presenter: CityListScreenPresenter?,
		resultManager: ICitiesFetchedResultsManager,
		logger: DTLogger
	) {
		self.presenter = presenter
		self.fetchedResultManager = resultManager
		self.logger = logger
	}
	
	// MARK: - Private methods
	
	/// Метод для получения лекарства из fetchedResultsController
	/// - Parameter indexPath: принимает текущий индекс ячейки
	/// - Returns: возвращает объект либо nil
	/// - Возврат nil считать ошибкой, так как этого не должно происходить
	private func fetchCity(at indexPath: IndexPath) -> DBCity? {
		guard let city = fetchedResultManager.fetchedResultsController.object(
			at: indexPath
		) as? DBCity else {
			logger.log(.error, "Ошибка каста object к объекту базы")
			return nil
		}
		
		return city
	}
}

// MARK: - Table view data source

extension CityListScreenDataSourceProvider: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let sections = fetchedResultManager.fetchedResultsController.sections {
			return sections[section].numberOfObjects
		} else {
			return 0
		}
	}
	
	func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath
	) -> UITableViewCell {
		
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: String(describing: CityCell.self),
			for: indexPath
		) as? CityCell else { return UITableViewCell() }
		
		let city = fetchCity(at: indexPath)
		
		cell.config(name: city?.name ?? "No name")
		
		return cell
	}
	
}

// MARK: - Table view delegate

extension CityListScreenDataSourceProvider: UITableViewDelegate {
	
	func tableView(
		_ tableView: UITableView,
		trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
	) -> UISwipeActionsConfiguration? {
		
		let deleteAction = UIContextualAction(
			style: .destructive,
			title: "Delete"
		) { [weak self] _, _, isDone in
			
			guard let city = self?.fetchCity(at: indexPath) else { return }
			self?.presenter?.deleteCity(city.name ?? "No Name")
			
			isDone(true)
		}
		
		let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
		
		return configuration
	}
}

