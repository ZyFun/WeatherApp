//
//  URLProvider.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation

public struct URLProvider: IRequest {
	var urlRequest: URLRequest?
	
	public static func fetchApiStringURL(with token: String, for city: String) -> String {
		let urlString = "http://api.openweathermap.org/data/2.5/forecast?q=\(city),uk&APPID=\(token)&units=metric&lang=ru"
		
		return urlString
	}
}
