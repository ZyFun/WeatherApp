//
//  APIWeatherResponse.swift
//  WeatherApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation

struct APIWeatherResponse: Codable {
	struct Coord: Codable {
		let lon: Double
		let lat: Double
	}
	
	struct Weather: Codable {
		let id: Int
		let main: String
		let description: String
		let icon: String
	}
	
	struct Main: Codable {
		let temp: Double
		let feelsLike: Double
		let tempMin: Double
		let tempMax: Double
		let pressure: Int
		let humidity: Int
	}
	
	struct Wind: Codable {
		let speed: Double
		let deg: Int
	}
	
	struct Clouds: Codable {
		let all: Int
	}
	
	struct Sys: Codable {
		let type: Int
		let id: Int
		let country: String
		let sunrise: TimeInterval
		let sunset: TimeInterval
	}
	
	let coord: Coord
	let weather: [Weather]
	let base: String
	let main: Main
	let visibility: Int
	let wind: Wind
	let clouds: Clouds
	let dt: TimeInterval
	let sys: Sys
	let timezone: Int
	let id: Int
	let name: String
	let cod: Int
}

