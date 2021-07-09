//
//  Message.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/9/21.
//

import Foundation

struct Message {

	var text: String
	var animal: Animal
	var date: Date
	
	init(dict: [String: Any]) throws {
		self.text = dict["text"] as! String
		self.animal = Animal(dict["animal"] as! String)
		self.date = Date(timeIntervalSince1970:  dict["date"] as! TimeInterval)
	}
	
	init(text: String, animal: Animal, date: Date) {
		self.text = text
		self.animal = animal
		self.date = date
	}
	
	var data: [String : Any] {
		return ["text" : text,
				"animal" : animal.name,
				"date": date.timeIntervalSince1970]
	}
	
}
