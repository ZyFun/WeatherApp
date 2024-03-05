//
//  AppDelegate.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		
		createAndShowStartVC()
		
		return true
	}
}

// MARK: - Initial application settings

private extension AppDelegate {
	/// Создание и отображение стартового ViewController
	func createAndShowStartVC() {
		let mainVC = WeatherScreenViewController()
		let navigationController = UINavigationController(rootViewController: mainVC)
		
		PresentationAssembly().weatherScreen.config(
			view: mainVC,
			navigationController: navigationController
		)

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}

