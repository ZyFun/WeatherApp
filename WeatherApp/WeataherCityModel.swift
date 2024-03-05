//
//  WeatherCityModel.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation

struct WeatherCityModel: Hashable {
	
	let id: String = UUID().uuidString
	let city: String
	let daysWeatherInfo: [WeatherInfo]
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	static func == (lhs: WeatherCityModel, rhs: WeatherCityModel) -> Bool {
		return lhs.id == rhs.id
	}
}
