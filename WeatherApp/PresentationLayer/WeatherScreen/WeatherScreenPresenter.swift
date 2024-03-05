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
}

final class WeatherScreenPresenter {
	// MARK: - Architecture Properties
	
	weak var view: WeatherScreenView?
	var router: WeatherScreenRoutingLogic?
	
	// MARK: - Dependency properties
	
	
	// MARK: - Private properties
	
	var networkManager: INetworkManager?
	
	// MARK: - Initializer
	
	required init(view: WeatherScreenView) {
		self.view = view
	}
}

// MARK: - Presentation Logic

extension WeatherScreenPresenter: WeatherScreenPresentationLogic {
	func getWeatherForCity() {
		networkManager?.getWeatherFor(
			city: "Москва,RU",
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
}
