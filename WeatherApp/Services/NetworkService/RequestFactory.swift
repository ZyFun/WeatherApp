//
//  RequestFactory.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation
import DTLogger

struct RequestFactory {
	struct WeatherDataRequest {
		
		static func weatherModelConfig(for city: String) -> RequestConfig<JSONParser<APIWeatherResponse>> {
			let token = TokenProvider.tokenAPI
			let urlRequest = URLProvider.fetchApiStringURL(with: token, for: city)
			let request = WeatherRequest(urlString: urlRequest)
			let parser = JSONParser<APIWeatherResponse>()
			return RequestConfig<JSONParser>(request: request, parser: parser)
		}
	}
}
