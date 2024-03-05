//
//  IdentifiableCell.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

protocol IdentifiableCell {}

extension IdentifiableCell {
	static var identifier: String {
		String(describing: Self.self)
	}
}
