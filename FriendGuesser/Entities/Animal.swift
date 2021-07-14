//
//  Animal.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/5/21.
//

import Foundation
import UIKit

struct Animal {
	
	var emoji: String
	var color: UIColor
	var name: String
	
	var user: String?
	
	init(emoji: String, color: UIColor, name: String, user: String? = nil) {
		self.emoji = emoji
		self.color = color
		self.name = name
		
		self.user = user
	}
	
	init(_ rawString: String) {
		switch rawString {
			case "lion": self = .lion
			case "koala": self = .koala
			case "fox": self = .fox
			case "unicorn": self = .unicorn
				
			default: self = .lion
		}
	}
}

extension Animal {
	static let lion: Animal    = Animal(emoji: "🦁", color: .orange, name: "lion")
	static let koala: Animal   = Animal(emoji: "🐨", color: .gray, name: "koala")
	static let fox: Animal	   = Animal(emoji: "🦊", color: .orange, name: "fox")
	static let unicorn: Animal = Animal(emoji: "🦄", color: .purple, name: "unicorn")
	
	static let all: [Animal] = [.lion, .koala, .fox, .unicorn]
}

extension Animal: Equatable {
	static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.emoji == rhs.emoji
	}
}
