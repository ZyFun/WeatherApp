//
//  CityListScreenViewController.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 06.03.2024.
//

import UIKit
import DTLogger

protocol CityListScreenView: AnyObject {
	func showAlertAddCity()
}

final class CityListScreenViewController: UIViewController {
	
	// MARK: - Public property
	
	var presenter: CityListScreenPresenter?
	
	// MARK: - Private property
	
	// MARK: - UIElements
	
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	private lazy var addCityBarButton: UIBarButtonItem = {
		let action = UIAction { [weak self] _ in
			self?.presenter?.addCity()
		}
		
		let button = UIBarButtonItem(systemItem: .add, primaryAction: action)
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
	
	// MARK: - Actions
	
}

// MARK: - Implementing delegate methods

extension CityListScreenViewController: CityListScreenView {
	func showAlertAddCity() {
		let alert = UIAlertController(
			title: "Новый город",
			message: "Введите название города России",
			preferredStyle: .alert
		)
		
		let addButton = UIAlertAction(
			title: "Добавить",
			style: .default
		) { [weak self] _ in
			guard let cityName = alert.textFields?.first?.text else { return }
			guard !cityName.isEmpty else { return }
//			self?.presenter.addNewCity(cityName)
		}
		
		let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
		
		alert.addAction(addButton)
		alert.addAction(cancelButton)
		alert.addTextField { textField in
			textField.placeholder = "Шатура"
		}
		
		present(alert, animated: true)
	}
}

// MARK: - Setup View

private extension CityListScreenViewController {
	func setup() {
		setupNavBar()
	}
	
	func setupNavBar() {
		navigationItem.rightBarButtonItem = addCityBarButton
	}
}
