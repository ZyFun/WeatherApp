//
//  UserDefaultStorageService.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 06.03.2024.
//

import Foundation

protocol IUserDefaultsStorageService {
	func saveCity(_ name: String)
	func loadCity() -> String
	func saveLanguage(_ locale: Language)
	func loadLanguage() -> Language
}

final class UserDefaultsStorageService: IUserDefaultsStorageService {
	enum Key: String {
		case city
		case locale
	}
	
	private let userDefaults = UserDefaults()
	
	// MARK: - City
	
	func saveCity(_ name: String) {
		userDefaults.set(name, forKey: Key.city.rawValue)
	}
	
	func loadCity() -> String {
		guard let cityName = userDefaults.string(forKey: Key.city.rawValue) else {
			return "Москва"
		}
		
		return cityName
	}
	
	// MARK: - Language
	
	func saveLanguage(_ locale: Language) {
		userDefaults.set(locale.rawValue, forKey: Key.locale.rawValue)
	}
	
	func loadLanguage() -> Language {
		guard let stringLanguage = userDefaults.string(forKey: Key.locale.rawValue) else { return .ru }
		return Language(rawValue: stringLanguage) ?? .ru
	}
}
