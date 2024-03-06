//
//  CityListScreenPresenter.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 06.03.2024.
//

import Foundation

protocol CityListScreenPresentationLogic: AnyObject {
	init(view: CityListScreenView)
}

final class CityListScreenPresenter {
	// MARK: - Public Properties
	
	weak var view: CityListScreenView?
	
	// MARK: - Private properties
	
	// MARK: - Initializer
	
	required init(view: CityListScreenView) {
		self.view = view
	}
}

// MARK: - Presentation Logic

extension CityListScreenPresenter: CityListScreenPresentationLogic {
	
}
