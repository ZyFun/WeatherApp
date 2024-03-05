//
//  APIWeatherResponse.swift
//  WeatherApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation

struct APIWeatherResponse: Codable {
	let cod: String
	let message: Int
	let cnt: Int
	let list: [WeatherInfo]
	let city: City
}

struct WeatherInfo: Codable {
	let dt: TimeInterval
	let main: MainWeather
	let weather: [WeatherDetail]
	let clouds: Clouds
	let wind: Wind
	let visibility: Int
	let pop: Double
	let rain: Rain?
	let sys: Sys
	let dtTxt: String
}

struct MainWeather: Codable {
	let temp: Double
	let feelsLike: Double
	let tempMin: Double
	let tempMax: Double
	let pressure: Int
	let seaLevel: Int
	let grndLevel: Int
	let humidity: Int
	let tempKf: Double
}

struct WeatherDetail: Codable {
	let id: Int
	let main: String
	let description: String
	let icon: String
}

struct Clouds: Codable {
	let all: Int
}

struct Wind: Codable {
	let speed: Double
	let deg: Int
	let gust: Double
}

struct Rain: Codable {
	let threeHours: Double

	enum CodingKeys: String, CodingKey {
		case threeHours = "3h"
	}
}

struct Sys: Codable {
	let pod: String
}

struct City: Codable {
	let id: Int
	let name: String
	let coord: Coord
	let country: String
	let population: Int
	let timezone: Int
	let sunrise: TimeInterval
	let sunset: TimeInterval
}

struct Coord: Codable {
	let lat: Double
	let lon: Double
}
