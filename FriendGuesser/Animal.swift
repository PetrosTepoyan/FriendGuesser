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
	
	var user: String?
}

extension Animal {
	static let lion: Animal = Animal(emoji: "🦁", color: .orange)
	static let koala: Animal = Animal(emoji: "🐨", color: .gray)
	static let fox: Animal = Animal(emoji: "🦊", color: .orange)
	static let unicorn: Animal = Animal(emoji: "🦄", color: .purple)
	
	static let all: [Animal] = [.lion, .koala, .fox, .unicorn]
}
