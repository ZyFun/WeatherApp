//
//  ViewController.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import UIKit
import DTLogger

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .blue
		
//			getData()
		
	}
	
//	func getData() {
//		let requestSender: IRequestSender = RequestSender()
//		
//		let requestConfig = RequestFactory.WeatherDataRequest.weatherModelConfig(for: "London")
//		requestSender.send(config: requestConfig) { result in
//			switch result {
//			case .success(let (model, _, _)):
//				DispatchQueue.main.async {
//					print(model?.name ?? "lol")
//				}
//			case .failure(let error):
//				DTLogger.shared.log(.error, error.localizedDescription)
//			}
//		}
//	}
	
}

