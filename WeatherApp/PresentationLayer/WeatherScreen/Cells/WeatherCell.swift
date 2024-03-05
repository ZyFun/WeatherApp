//
//  WeatherCell.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import UIKit

final class WeatherCell: UITableViewCell, IdentifiableCell {
	
	// MARK: - Private properties
	
	private let temperatureHStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.distribution = .equalSpacing
		stackView.alignment = .center
		stackView.spacing = 2
		return stackView
	}()
	
	private let dayLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 3
		return label
	}()
	
	private let temperatureLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.isHidden = true
		return label
	}()
	
	// MARK: - Initializer
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setup()
		addViews()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Override Methods
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		dayLabel.text = ""
		temperatureLabel.text = ""
	}
}

// MARK: - Public methods

extension WeatherCell {
	func config(
		day: String,
		temperature: Double
	) {
		dayLabel.text = day
		temperatureLabel.text = "\(temperature)"
	}
}

// MARK: - Configuration methods

private extension WeatherCell {
	func setup() {
		setupUI()
	}
	
	func setupUI() {
		
	}
	
	func addViews() {
		contentView.addSubview(temperatureHStackView)
		
		temperatureHStackView.addArrangedSubview(dayLabel)
		temperatureHStackView.addArrangedSubview(temperatureLabel)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			contentView.heightAnchor.constraint(
				greaterThanOrEqualToConstant: 56
			),
			
			temperatureHStackView.centerYAnchor.constraint(
				equalTo: contentView.centerYAnchor
			),
			temperatureHStackView.topAnchor.constraint(
				greaterThanOrEqualTo: contentView.topAnchor,
				constant: Constants.paddingContent
			),
			temperatureHStackView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.paddingContent
			),
			temperatureHStackView.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.paddingContent
			),
			temperatureHStackView.bottomAnchor.constraint(
				lessThanOrEqualTo: contentView.bottomAnchor,
				constant: -Constants.paddingContent
			)
		])
	}
}

// MARK: - Constants

private extension WeatherCell {
	struct Constants {
		static let paddingContent: CGFloat = 16
	}
}

