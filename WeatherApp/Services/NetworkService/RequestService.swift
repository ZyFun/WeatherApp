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
	
	func sendAsync<Parser>(
		config: RequestConfig<Parser>
	) async throws -> (Parser.Model?, Data?, URLResponse?) where Parser: IParser
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
				
				let serverMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
				result = .failure(.messageError(serverMessage, statusCode))
				return
			}
			
			#if DEBUG
			if let data = data, let jsonString = String(data: data, encoding: .utf8) {
				DTLogger.shared.log(.info, "Response JSON: \(jsonString)")
			}
			#endif
			
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
	
	func sendAsync<Parser>(
		config: RequestConfig<Parser>
	) async throws -> (Parser.Model?, Data?, URLResponse?) where Parser: IParser {
		
		guard let urlRequest = config.request.urlRequest else {
			throw NetworkError.invalidURL
		}
		
		let (data, response) = try await URLSession.shared.data(for: urlRequest)
		
		guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
			DTLogger.shared.log(.error, "Ошибка получения кода статуса")
			throw NetworkError.statusCodeError
		}
		
		if !(200..<300).contains(statusCode) {
			DTLogger.shared.log(.info, "Status code: \(statusCode.description)")
			
			let serverMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
			throw NetworkError.messageError(serverMessage, statusCode)
		}
		
		#if DEBUG
		if let jsonString = String(data: data, encoding: .utf8) {
			DTLogger.shared.log(.info, "Response JSON: \(jsonString)")
		}
		#endif
		
		if let parseModel: Parser.Model = config.parser?.parse(data: data) {
			return (parseModel, nil, nil)
		} else {
			throw NetworkError.parseError
		}
	}
}
