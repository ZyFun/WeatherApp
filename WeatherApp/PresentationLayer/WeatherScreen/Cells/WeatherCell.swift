//
//  WeatherCell.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import UIKit

final class WeatherCell: UITableViewCell, IdentifiableCell {
	
	// MARK: - Private properties
	
	private let temperatureVStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.distribution = .fill
		stackView.spacing = 8
		return stackView
	}()
	
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
		return label
	}()
	
	private let temperatureLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	// MARK: - Initializer
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Override Methods
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		dayLabel.text = ""
		temperatureLabel.text = ""
		descriptionLabel.text = ""
	}
}

// MARK: - Public methods

extension WeatherCell {
	func config(
		day: String,
		temperature: String,
		description: String
	) {
		dayLabel.text = day
		temperatureLabel.text = temperature
		descriptionLabel.text = description
	}
}

// MARK: - Configuration methods

private extension WeatherCell {
	func setup() {
		addViews()
		setupConstraints()
	}
	
	func addViews() {
		contentView.addSubview(temperatureVStackView)
		temperatureVStackView.addArrangedSubview(temperatureHStackView)
		temperatureHStackView.addArrangedSubview(dayLabel)
		temperatureHStackView.addArrangedSubview(temperatureLabel)
		
		temperatureVStackView.addArrangedSubview(descriptionLabel)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			contentView.heightAnchor.constraint(
				greaterThanOrEqualToConstant: 56
			),
			
			temperatureVStackView.centerYAnchor.constraint(
				equalTo: contentView.centerYAnchor
			),
			temperatureVStackView.topAnchor.constraint(
				greaterThanOrEqualTo: contentView.topAnchor,
				constant: Constants.paddingContent
			),
			temperatureVStackView.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.paddingContent
			),
			temperatureVStackView.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.paddingContent
			),
			temperatureVStackView.bottomAnchor.constraint(
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

