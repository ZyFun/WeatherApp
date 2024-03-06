//
//  CityCell.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 06.03.2024.
//

import UIKit

final class CityCell: UITableViewCell, IdentifiableCell {
	
	// MARK: - Private properties
	
	private let nameLabel: UILabel = {
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
		
		nameLabel.text = ""
	}
	
	// MARK: - Private methods
	
}

// MARK: - Public methods

extension CityCell {
	func config(
		name: String
	) {
		nameLabel.text = name
	}
}

// MARK: - Configuration methods

private extension CityCell {
	func setup() {
		addViews()
		setupConstraints()
	}
	
	func addViews() {
		contentView.addSubview(nameLabel)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			contentView.heightAnchor.constraint(
				greaterThanOrEqualToConstant: 56
			),
			
			nameLabel.topAnchor.constraint(
				equalTo: contentView.safeAreaLayoutGuide.topAnchor,
				constant: Constants.vPadding
			),
			nameLabel.leadingAnchor.constraint(
				equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
				constant: Constants.hPadding
			),
			nameLabel.trailingAnchor.constraint(
				equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
				constant: -Constants.hPadding
			),
			nameLabel.bottomAnchor.constraint(
				equalTo: contentView.safeAreaLayoutGuide.bottomAnchor,
				constant: -Constants.vPadding
			),
		])
	}
}

// MARK: - Constants

private extension CityCell {
	struct Constants {
		static let vPadding: CGFloat = 6
		static let hPadding: CGFloat = 25
	}
}
