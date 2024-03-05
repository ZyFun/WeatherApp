//
//  RequestService.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation
import DTLogger

protocol IRequest {
	var urlRequest: URLRequest? { get }
}

protocol IRequestSender {
	func send<Parser>(
		config: RequestConfig<Parser>,
		completionHandler: @escaping (Result<(Parser.Model?, Data?, URLResponse?), NetworkError>) -> Void
	)
}

struct RequestConfig<Parser> where Parser: IParser {
	let request: IRequest
	let parser: Parser?
}

final class RequestSender: IRequestSender {
	let logger = DTLogger.shared
	
	func send<Parser>(
		config: RequestConfig<Parser>,
		completionHandler: @escaping (Result<(Parser.Model?, Data?, URLResponse?), NetworkError>) -> Void
	) where Parser: IParser {
		guard let urlRequest = config.request.urlRequest else {
			completionHandler(.failure(.invalidURL))
			return
		}
		
		let session = URLSession.shared
		let task = session.dataTask(with: urlRequest) { data, response, error in
			
			let result: Result<(Parser.Model?, Data?, URLResponse?), NetworkError>
			
			defer {
				completionHandler(result)
			}
			
			if let error = error {
				DTLogger.shared.log(.error, error.localizedDescription)
				result = .failure(.networkError)
				return
			}
			
			guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
				DTLogger.shared.log(.error, "Ошибка получения кода статуса")
				result = .failure(.statusCodeError)
				return
			}
			
			if !(200..<300).contains(statusCode) {
				DTLogger.shared.log(.info, "Status code: \(statusCode.description)")
				
				switch statusCode {
				case 400:
					let serverMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
					result = .failure(.messageError(serverMessage))
					return
				case 401:
					result = .failure(.authError)
					return
				case 404:
					result = .failure(.notFound)
					return
				case 500...:
					result = .failure(.serverUnavailable)
					return
				default:
					DTLogger.shared.log(.error, statusCode.description)
					let serverMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
					result = .failure(.messageError(serverMessage))
					return
				}
			}
			
			// Для отладки и сверки данных
			if let data = data, let jsonString = String(data: data, encoding: .utf8) {
				DTLogger.shared.log(.info, "Response JSON: \(jsonString)")
			}
			
			if let data = data,
			   let parseModel: Parser.Model = config.parser?.parse(data: data) {
				result = .success((parseModel, nil, nil))
			} else if let data = data {
				// кейс на случай, когда не нужно парсить модель, но ответ получить нужно
				result = .success((nil, data, response))
			} else {
				result = .failure(.parseError)
			}
		}
		task.resume()
	}
}
