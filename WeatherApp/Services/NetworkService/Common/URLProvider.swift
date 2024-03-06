//
//  URLProvider.swift
//  WeaterApp
//
//  Created by Дмитрий Данилин on 05.03.2024.
//

import Foundation

public struct URLProvider: IRequest {
	var urlRequest: URLRequest?
	
	public static func fetchApiStringURL(
		with token: String,
		for city: String,
		language: Language) -> String {
			// Я не смог найти в документации, как получить список городов из запроса,
			// для более корректного поиска нужного города. Поэтому пока что хорошо работает
			// только ввод пользователем в ручную названия города России.
			// Города других стран с ключом ru не ищет. Но если условно указать uk,
			// то для поиска по России русский ввод перестаёт работать и нужно
			// дополнительно добавлять так: Moskow,RU. Подобное не работает для других стран.
			// Если дать мне больше времени, я бы разобрался на примере других проектов с этим api, которые лежат на гитхабе
			// Сейчас часть страниц документации открывается с ошибкой 404.
			// К примеру смену локали пришлось смотреть на ранних проектах.
		let urlString = "http://api.openweathermap.org/data/2.5/forecast?q=\(city),ru&APPID=\(token)&units=metric&lang=\(language)"
		
		return urlString
	}
}
