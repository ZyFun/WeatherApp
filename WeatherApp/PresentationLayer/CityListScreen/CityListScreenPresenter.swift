//
//  CityListScreenPresenter.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 06.03.2024.
//

import Foundation
import DTLogger

protocol CityListScreenPresentationLogic: AnyObject {
	init(view: CityListScreenView)
	
	func openAlertAddCity()
	func addNewCity(_ cityName: String)
	func deleteCity(_ cityName: String)
	
	func setCurrentCity(cityName: String)
	func closeScreen()
}

final class CityListScreenPresenter {
	// MARK: - Public Properties
	
	weak var view: CityListScreenView?
	var router: CityListScreenRouter?
	
	// MARK: - Private properties
	
	// MARK: - Dependency properties
	
	var logger: DTLogger?
	var coreDataService: ICoreDataStorageService?
	var userDefaultsService: IUserDefaultsStorageService?
	
	// MARK: - Initializer
	
	required init(view: CityListScreenView) {
		self.view = view
	}
}

// MARK: - Presentation Logic

extension CityListScreenPresenter: CityListScreenPresentationLogic {
	func closeScreen() {
		router?.routeTo(target: .closeScreen)
	}
	
	func openAlertAddCity() {
		view?.showAlertAddCity()
	}
	
	func setCurrentCity(cityName: String) {
		userDefaultsService?.saveCity(cityName)
	}
	
	func addNewCity(_ cityName: String) {
		let cityModel = CityModel(name: cityName)
		
		coreDataService?.performSave { [weak self] context in
			self?.coreDataService?.save(cityModel, context: context)
		} completion: { [weak self] result in
			switch result {
			case .success():
				// обновление таблицы работает автоматически, поэтому пока не требуется
				break
			case .failure(let error):
				self?.logger?.log(.error, error.localizedDescription)
			}
		}
	}
	
	func deleteCity(_ cityName: String) {
		coreDataService?.performSave({ [weak self] context in
			do {
				try self?.coreDataService?.deleteObject(withName: cityName, context: context)
			} catch {
				self?.logger?.log(.error, error.localizedDescription)
			}
		}, completion: { [weak self] result in
			switch result {
			case .success():
				// Пока не требуется, так как обновление происходит автоматически
				break
			case .failure(let error):
				self?.logger?.log(.error, error.localizedDescription)
			}
		})
	}
}
