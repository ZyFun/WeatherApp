//
//  WeatherScreenDataSourceProvider.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import UIKit
import DTLogger

protocol IWeatherScreenDataSourceProvider {
	var viewModels: [WeatherCellViewModel] { get set }
	func makeDataSource(with tableView: UITableView)
	func updateDataSource()
}

final class WeatherScreenDataSourceProvider: NSObject, IWeatherScreenDataSourceProvider {
	
	// MARK: - Public properties
	
	var viewModels: [WeatherCellViewModel] = []
	
	// MARK: - Private properties
	
	private var dataSource: UITableViewDiffableDataSource<Section, WeatherCellViewModel>?
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
					
					cell.config(
						day: model.date,
						temperature: model.temperature,
						description: model.description
					)
					
					return cell
				}
			}
		)
	}
	
	func updateDataSource() {
		var snapshot = NSDiffableDataSourceSnapshot<Section, WeatherCellViewModel>()
		snapshot.appendSections([.main])
		snapshot.appendItems(viewModels, toSection: .main)
		
		dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
	}
}
