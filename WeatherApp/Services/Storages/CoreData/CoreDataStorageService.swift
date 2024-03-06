//
//  CoreDataStorageService.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 06.03.2024.
//

import CoreData
import DTLogger

/// Протокол для работы с базой данных
protocol ICoreDataStorageService {
	/// Метод обработки изменений в контексте и сохранения результатов в базе
	/// - Tip: Метод использует контекст для записи.
	/// - Parameters:
	///   - block: блок  обработки методов работы с базой, с последующей попыткой сохранения изменений.
	///   - completion: блок завершения с результатами обработки.
	/// ```
	/// // Пример использования:
	/// coreDataStorage.performSave({ context in
	///     self.coreDataStorage.save(item, context: context)
	/// }, completion: { result in
	///     switch result {
	///     case .success:
	///         // Выполнение работы после подтверждения успешности сохранения
	///     case .failure(let error):
	///         // обработка какой то ошибки
	///     }
	/// })
	/// ```
	func performSave(_ block: @escaping (NSManagedObjectContext) -> Void, completion: @escaping (Result<Void, Error>) -> Void)
	
	/// Метод для сохранения объекта
	/// - В случае совпадения name, объект перезаписывается.
	/// - Parameters:
	///   - city: <#city description#>
	///   - context: принимает контекст, в котором производится работа с данными.

	func save(_ city: CityModel, context: NSManagedObjectContext)
	
	/// Метод для получения всех объектов из CoreData в контексте для чтения
	/// - Returns: <#description#>
	func fetchObjects() throws -> [DBCity]
	
	/// Метод для получения объекта по имени в текущем контексте
	/// - tip: Используется в случае необходимости работы с объектами в одном контексте.
	/// - Так же используется для удаления объекта из базы в методе deleteObject(withId:)
	/// - Parameters:
	///   - id: <#id description#>
	///   - context: принимает контекст, в котором производится работа с данными.
	/// - Returns: <#description#>
	func fetchObject(withName name: String, context: NSManagedObjectContext) throws -> DBCity?
	
	/// Метод для получения объекта по имени
	/// - Использует контекст для чтения
	/// - Parameter name: <#name description#>
	/// - Returns: <#description#>
	func fetchObject(withId name: String) throws -> DBCity?
	
	/// Метод для получения данных из базы с использованием NSFetchedResultsController
	/// - Parameters:
	///   - entityName: <#entityName description#>
	///   - keyForSort: <#keyForSort description#>
	///   - sortAscending: <#sortAscending description#>
	/// - Returns: <#description#>
	func fetchResultController(
		entityName: String,
		keyForSort: String,
		sortAscending: Bool
	) -> NSFetchedResultsController<NSFetchRequestResult>
	
	/// Метод для удаления объекта по имени
	/// - Parameters:
	///   - name: <#name description#>
	///   - context: принимает контекст, в котором производится работа с данными.
	func deleteObject(withName name: String, context: NSManagedObjectContext) throws
}
 
final class CoreDataStorageService {
	static let shared = CoreDataStorageService()
	
	// MARK: - Core Data stack
	
	private lazy var container: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "WeatherApp")
		container.loadPersistentStores { storeDescription, error in
			if let error = error {
				DTLogger.shared.log(.error, error.localizedDescription)
			} else {
				DTLogger.shared.log(.debug, "\(storeDescription)")
			}
		}
		return container
	}()
	
	private lazy var readContext: NSManagedObjectContext = {
		let context = container.viewContext
		context.automaticallyMergesChangesFromParent = true
		return context
	}()
	
	private lazy var writeContext: NSManagedObjectContext = {
		let context = container.newBackgroundContext()
		context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
		return context
	}()
	
	private init() {}
}

// MARK: - CRUD

extension CoreDataStorageService: ICoreDataStorageService {
	
	func save(_ city: CityModel, context: NSManagedObjectContext) {
		let managedObject = NSEntityDescription.insertNewObject(
			forEntityName: String(describing: DBCity.self),
			into: context
		)
		
		guard let dbObject = managedObject as? DBCity else {
			DTLogger.shared.log(.error, "Ошибка каста до DBCity")
			return
		}
		
		dbObject.name = city.name
		
		DTLogger.shared.log(.info, "Запуск сохранения объекта \(dbObject.name ?? "по имени")")
	}
	
	func fetchObjects() throws -> [DBCity] {
		let fetchRequest: NSFetchRequest<DBCity> = DBCity.fetchRequest()
		let dbObjects = try readContext.fetch(fetchRequest)
		return dbObjects
	}
	
	func fetchObject(withName name: String, context: NSManagedObjectContext) throws -> DBCity? {
		let fetchRequest: NSFetchRequest<DBCity> = DBCity.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "name == %@", name)
		
		let results = try context.fetch(fetchRequest)
		return results.first
	}
	
	func fetchObject(withId name: String) throws -> DBCity? {
		let fetchRequest: NSFetchRequest<DBCity> = DBCity.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "name == %@", name)
		
		let results = try readContext.fetch(fetchRequest)
		return results.first
	}
	
	func fetchResultController(
		entityName: String,
		keyForSort: String,
		sortAscending: Bool
	) -> NSFetchedResultsController<NSFetchRequestResult> {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
		let descriptor = NSSortDescriptor(key: keyForSort, ascending: sortAscending)
		
		fetchRequest.sortDescriptors = [descriptor]
		fetchRequest.fetchBatchSize = 15
		
		let fetchResultController = NSFetchedResultsController<NSFetchRequestResult>(
			fetchRequest: fetchRequest,
			managedObjectContext: readContext,
			sectionNameKeyPath: nil,
			cacheName: nil
		)
		
		do {
			try fetchResultController.performFetch()
		} catch {
			DTLogger.shared.log(.error, error.localizedDescription)
		}
		
		return fetchResultController
	}
	
	func deleteObject(withName name: String, context: NSManagedObjectContext) throws {
		if let object = try fetchObject(withName: name, context: context) {
			context.delete(object)
			DTLogger.shared.log(.info, "Запуск удаления объекта с именем: \(name)")
		} else {
			DTLogger.shared.log(.info,"Объект с именем \(name) не найден")
		}
	}
	
	
	// MARK: - Save context
	
	func performSave(
		_ block: @escaping (NSManagedObjectContext) -> Void,
		completion: @escaping (Result<Void, Error>) -> Void
	) {
		let context = writeContext
		context.perform { [weak self] in
			block(context)
			DTLogger.shared.log(.info, "Проверка контекста на изменение")
			if context.hasChanges {
				DTLogger.shared.log(.info, "Данные изменены, попытка сохранения")
				do {
					try self?.performSave(in: context) {
						DTLogger.shared.log(.info, "Изменения сохранены")
						completion(.success(()))
					}
				} catch {
					completion(.failure(error))
				}
			} else {
				DTLogger.shared.log(.info, "Изменений нет")
				completion(.success(()))
			}
			
			DTLogger.shared.log(.info, "Проверка контекста на изменение закончена")
		}
	}
	
	private func performSave(in context: NSManagedObjectContext, completion: () -> Void) throws {
		try context.save()
		completion()
	}
}
