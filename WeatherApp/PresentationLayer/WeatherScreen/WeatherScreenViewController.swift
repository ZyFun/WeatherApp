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
	
	private lazy var openCityScreenBarButton: UIBarButtonItem = {
		let action = UIAction { [weak self] _ in
			self?.presenter?.openCityScreen()
		}
		
		let button = UIBarButtonItem(
			image: UIImage(systemName: "globe.americas.fill"),
			primaryAction: action
		)
		
		return button
	}()
	
	private lazy var changeLanguageMenu: UIMenu = {
		let enAction = UIAction(title: "en") { _ in
			self.presenter?.setLanguage(.en)
		}
		
		let ruAction = UIAction(title: "ru") { _ in
			self.presenter?.setLanguage(.ru)
		}
		
		let menu = UIMenu(title: "Выбор языка", children: [enAction, ruAction])
		
		return menu
	}()
	
	private lazy var changeLanguageBarButton: UIBarButtonItem = {
		let button = UIBarButtonItem(
			image: UIImage(systemName: "globe")
		)
		
		button.menu = changeLanguageMenu
		
		return button
	}()
	
	// MARK: - Life Cycle
	
	override func loadView() {
		super.loadView()
		
		view = tableView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
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
		setupNavBar()
		setupTableView()
	}
	
	func setupNavBar() {
		navigationItem.rightBarButtonItem = openCityScreenBarButton
		navigationItem.leftBarButtonItem = changeLanguageBarButton
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
