//
//  WeatherScreenViewController.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import UIKit

protocol WeatherScreenView: AnyObject {
	func updateView(_ viewModel: WeatherCityModel)
}

final class WeatherScreenViewController: UIViewController {
	
	// MARK: - Public property
	
	var presenter: WeatherScreenPresenter?
	
	// MARK: - Private property
	
	// MARK: - UIElements
	
	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 16
		stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
		stackView.isLayoutMarginsRelativeArrangement = true
		return stackView
	}()
	
	private let hStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		return stackView
	}()
	
	private let cityLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "loading..."
		label.textAlignment = .center
		return label
	}()
	
	private let cityLabel2: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Температура: "
		label.textAlignment = .center
		label.setContentHuggingPriority(.defaultLow, for: .vertical)
		return label
	}()
	
	private let cityLabel3: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "loading..."
		label.textAlignment = .center
		label.setContentHuggingPriority(.defaultLow, for: .vertical)
		return label
	}()
	
	
	// MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
		
		presenter?.getWeatherForCity()
	}
	
	// MARK: - Actions
	
}

// MARK: - Implementing delegate methods

extension WeatherScreenViewController: WeatherScreenView {
	func updateView(_ viewModel: WeatherCityModel) {
		DispatchQueue.main.async { [weak self] in
			self?.cityLabel3.text = "\(viewModel.daysWeatherInfo.first!.main.temp)"
			self?.title = viewModel.city
		}
	}
}

// MARK: - Setup View

private extension WeatherScreenViewController {
	func setup() {
		view.backgroundColor = .blue
		
		setupConstraints()
	}
	
	func setupConstraints() {
		view.addSubview(stackView)
		
		stackView.addArrangedSubview(cityLabel)
		
		stackView.addArrangedSubview(hStackView)
		hStackView.addArrangedSubview(cityLabel2)
		hStackView.addArrangedSubview(cityLabel3)
		
		stackView.addArrangedSubview(UIView())
		
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20),
		])
	}
}
