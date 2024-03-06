//
//  CityListScreenViewController.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 06.03.2024.
//

import UIKit
import DTLogger

protocol CityListScreenView: AnyObject {
	
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
			DTLogger.shared.log(.debug, "skidysh")
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
