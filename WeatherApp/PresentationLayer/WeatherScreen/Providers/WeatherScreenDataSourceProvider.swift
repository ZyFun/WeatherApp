//
//  WeatherScreenDataSourceProvider.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import UIKit
import DTLogger

protocol IWeatherScreenDataSourceProvider {
	var viewModels: [WeatherCityModel] { get set }
	func makeDataSource(with tableView: UITableView)
	func updateDataSource(_ showComplete: Bool)
}

final class WeatherScreenDataSourceProvider: NSObject, IWeatherScreenDataSourceProvider {
	
	// MARK: - Public properties
	
	var viewModels: [WeatherCityModel] = []
	
	// MARK: - Private properties
	
	private var dataSource: UITableViewDiffableDataSource<Section, WeatherCityModel>?
}

// MARK: - Table view data source

extension WeatherScreenDataSourceProvider {
	enum Section: Int {
		case main
	}
	
	func makeDataSource(with cardsTableView: UITableView) {
		dataSource = UITableViewDiffableDataSource(
			tableView: cardsTableView,
			cellProvider: { tableView, indexPath, model -> UITableViewCell? in
				guard let section = Section(rawValue: indexPath.section) else {
					return UITableViewCell()
				}
				
				switch section {
				case .main:
					guard let cell = tableView.dequeueReusableCell(
						withIdentifier: WeatherCell.identifier,
						for: indexPath
					) as? WeatherCell else {
						return UITableViewCell()
					}
					
					cell.config(day: model.daysWeatherInfo.first!.dtTxt, temperature: model.daysWeatherInfo.first!.main.temp)
					
					return cell
				}
			}
		)
	}
	
	func updateDataSource(_ showComplete: Bool) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, WeatherCityModel>()
		snapshot.appendSections([.main])
		snapshot.appendItems(viewModels, toSection: .main)
	}
}
