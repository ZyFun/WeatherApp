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
		return RequestSender()
	}()
	
	lazy var coreDataService: ICoreDataStorageService = {
		return CoreDataStorageService.shared
	}()
	
	lazy var userDefaultsService: IUserDefaultsStorageService = {
		return UserDefaultsStorageService()
	}()
}
