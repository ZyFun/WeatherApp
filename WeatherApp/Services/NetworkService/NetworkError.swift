//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation

enum NetworkError: Error {
	case authError
	case serverUnavailable
	case unownedError
	case invalidURL
	case networkError
	case statusCodeError
	case parseError
	case notFound
	case messageError(String, Int? = nil)
	
	var describing: String {
		switch self {
		case .authError:
			return "ошибка авторизации"
		case .messageError(let message, let statusCode):
			return "\(message): \(statusCode ?? 0)"
		case .serverUnavailable:
			return "все упало"
		case .unownedError:
			return "Неизвестная ошибка. До свидания"
		case .invalidURL:
			return "API Error: Неправильно указан URL."
		case .networkError:
			return "Ошибка сети. Попробовать загрузить данные еще раз?"
		case .statusCodeError:
			return "Ошибка получения кода статуса. Обратитесь к разработчику"
		case .parseError:
			return "Ошибка парсинга данных. Обратитесь к разработчику"
		case .notFound:
			return "Неудачный запрос, не найдено на сервере"
		}
	}
}
