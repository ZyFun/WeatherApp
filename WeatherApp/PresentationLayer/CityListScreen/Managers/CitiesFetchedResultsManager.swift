//
//  CitiesFetchedResultsManager.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 06.03.2024.
//

import UIKit
import CoreData
import DTLogger

protocol ICitiesFetchedResultsManager {
	/// Используется для передачи таблицы с вью в FetchedResultsManager
	var tableView: UITableView? { get set }
	/// Используется для связи с DataSourceProvider
	var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> { get set }
}

final class CitiesFetchedResultsManager: NSObject,
										 ICitiesFetchedResultsManager {
	weak var tableView: UITableView?
	var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>
	
	// MARK: - Dependencies
	
	private let logger: DTLogger
	
	// MARK: - Initializer
	
	init(
		fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>,
		logger: DTLogger
	) {
		self.fetchedResultsController = fetchedResultsController
		self.logger = logger
		
		super.init()
		self.fetchedResultsController.delegate = self
	}
}

extension CitiesFetchedResultsManager: NSFetchedResultsControllerDelegate {
	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView?.beginUpdates()
	}
	
	func controller(
		_ controller: NSFetchedResultsController<NSFetchRequestResult>,
		didChange anObject: Any,
		at indexPath: IndexPath?,
		for type: NSFetchedResultsChangeType,
		newIndexPath: IndexPath?
	) {
		
		switch type {
		case .insert:
			if let indexPath = newIndexPath {
				tableView?.insertRows(at: [indexPath], with: .automatic)
			}
		case .delete:
			if let indexPath = indexPath {
				tableView?.deleteRows(at: [indexPath], with: .automatic)
			}
		case .move:
			if let indexPath = indexPath {
				tableView?.deleteRows(at: [indexPath], with: .automatic)
			}
			
			if let newIndexPath = newIndexPath {
				tableView?.insertRows(at: [newIndexPath], with: .automatic)
			}
		case .update:
			if let indexPath = indexPath {
				guard let city = fetchedResultsController.object(at: indexPath) as? DBCity else {
					logger.log(.error, "Не удалось скастить до объекта базы")
					return
				}
				let cell = tableView?.cellForRow(at: indexPath) as? CityCell

				cell?.config(name: city.name ?? "No name")
			}
		@unknown default:
			logger.log(.error, "Что то пошло не так в NSFetchedResultsControllerDelegate")
		}
	}
	
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView?.endUpdates()
	}
}
