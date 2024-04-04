//
//  WeatherScreenPresenter.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation
import DTLogger

protocol WeatherScreenPresentationLogic: AnyObject {
	init(view: WeatherScreenView)
	
	func getWeatherForCity()
	func openCityScreen()
	func setLanguage(_ language: Language)
}

final class WeatherScreenPresenter {
	// MARK: - Architecture Properties
	
	weak var view: WeatherScreenView?
	var router: WeatherScreenRoutingLogic?
	
	// MARK: - Dependency properties
	
	var networkManager: INetworkManager!
	var userDefaultsService: IUserDefaultsStorageService!
	
	
	// MARK: - Private properties
	
	// MARK: - Initializer
	
	required init(view: WeatherScreenView) {
		self.view = view
	}
}

// MARK: - Presentation Logic

extension WeatherScreenPresenter: WeatherScreenPresentationLogic {
	func setLanguage(_ language: Language) {
		userDefaultsService.saveLanguage(language)
		getWeatherForCity()
	}
	
	func openCityScreen() {
		router?.routeTo(target: .cityListScreen)
	}
	
	func getWeatherForCityDeprecated() {
		guard let userDefaultsService else {
			return assertionFailure("Не инициализирован UserDefaults")
		}
		
		networkManager?.getWeatherFor(
			city: userDefaultsService.loadCity(),
			language: userDefaultsService.loadLanguage(),
			completion: { [weak self] result in
				switch result {
				case .success(let serverModel):
					let city = WeatherViewModel(
						city: serverModel.city.name
					)
					
					var infoModels: [WeatherCellViewModel] = []
					
					serverModel.list.forEach { model in
						if let description = model.weather.first?.description {
							let infoModel = WeatherCellViewModel(
								date: model.dtTxt,
								temperature: "\(model.main.temp)",
								description: description
							)
							
							infoModels.append(infoModel)
						} else {
							let infoModel = WeatherCellViewModel(
								date: model.dtTxt,
								temperature: "\(model.main.temp)",
								description: ""
							)
							
							infoModels.append(infoModel)
						}
					}
					
					self?.view?.updateView(city)
					self?.view?.display(models: infoModels)
				case .failure(let error):
					DTLogger.shared.log(.error, error.localizedDescription)
				}
			}
		)
	}
	
	func getWeatherForCity() {
		Task { [weak self] in
			guard let self else {return }
			
			do {
				let serverModel = try await self.networkManager.getWeatherFor(
					city: self.userDefaultsService.loadCity(),
					language: self.userDefaultsService.loadLanguage()
				)
				
				let city = WeatherViewModel(
					city: serverModel.city.name
				)
				
				var infoModels: [WeatherCellViewModel] = []
				
				serverModel.list.forEach { model in
					if let description = model.weather.first?.description {
						let infoModel = WeatherCellViewModel(
							date: model.dtTxt,
							temperature: "\(model.main.temp)",
							description: description
						)
						
						infoModels.append(infoModel)
					} else {
						let infoModel = WeatherCellViewModel(
							date: model.dtTxt,
							temperature: "\(model.main.temp)",
							description: ""
						)
						
						infoModels.append(infoModel)
					}
				}
				
				view?.updateView(city)
				view?.display(models: infoModels)
			} catch let error as NetworkError {
				// Для вызова определенных методов
				DTLogger.shared.log(.error, error.localizedDescription)
			} catch {
				// Для вызова общего метода неизвестной ошибки
				DTLogger.shared.log(.error, error.localizedDescription)
			}
		}
	}
}
