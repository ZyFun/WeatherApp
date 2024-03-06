//
//  ServiceAssembly.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation
import DTLogger

final class ServiceAssembly {
	lazy var logger: DTLogger = {
		return DTLogger.shared
	}()
	
	lazy var requestService: IRequestSender = {
		var requestService = RequestSender()
		return requestService
	}()
	
	lazy var coreDataService: ICoreDataStorageService = {
		return CoreDataStorageService.shared
	}()
}
