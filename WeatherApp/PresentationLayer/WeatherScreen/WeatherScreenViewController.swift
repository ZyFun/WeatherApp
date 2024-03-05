//
//  WeatherScreenViewController.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import UIKit

protocol WeatherScreenView: AnyObject {
	func updateView(_ viewModel: WeatherViewModel)
	func display(models: [WeatherCellViewModel])
}

final class WeatherScreenViewController: UIViewController {
	
	// MARK: - Public property
	
	var presenter: WeatherScreenPresenter?
	var dataSourceProvider: IWeatherScreenDataSourceProvider?
	
	// MARK: - Private property
	
	// MARK: - UIElements
	
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	
	// MARK: - Life Cycle
	
	override func loadView() {
		super.loadView()
		
		view = tableView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
		
		presenter?.getWeatherForCity()
	}
	
	// MARK: - Actions
	
}

// MARK: - Implementing delegate methods

extension WeatherScreenViewController: WeatherScreenView {
	func updateView(_ viewModel: WeatherViewModel) {
		DispatchQueue.main.async { [weak self] in
			self?.title = viewModel.city
		}
	}
	
	func display(models: [WeatherCellViewModel]) {
		dataSourceProvider?.viewModels = models
		DispatchQueue.main.async { [weak self] in
			self?.dataSourceProvider?.updateDataSource()
		}
	}
}

// MARK: - Setup View

private extension WeatherScreenViewController {
	func setup() {
		setupTableView()
	}
	
	func setupTableView() {
		registerElements()
		
		dataSourceProvider?.makeDataSource(with: tableView)
	}
	
	func registerElements() {
		tableView.register(
			WeatherCell.self,
			forCellReuseIdentifier: WeatherCell.identifier
		)
	}
}
