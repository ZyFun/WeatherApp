//
//  JSONParser.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation
import DTLogger

protocol IParser {
	associatedtype Model
	func parse(data: Data) -> Model?
}

final class JSONParser<Model: Codable>: IParser {
	func parse(data: Data) -> Model? {
		var model: Model?
		
		do {
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			model = try decoder.decode(Model.self, from: data)
		} catch {
			DTLogger.shared.log(.error, error.localizedDescription)
		}
		return model
	}
	
	func parse(model: Model) -> Data {
		var data: Data = Data()
		
		do {
			let encoder = JSONEncoder()
			encoder.keyEncodingStrategy = .convertToSnakeCase
			data = try encoder.encode(model)
		} catch {
			DTLogger.shared.log(.error, error.localizedDescription)
		}
		return data
	}
}
