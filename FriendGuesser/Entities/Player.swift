//
//  Player.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/14/21.
//

import Foundation
import MessageKit
import UIKit
import FirebaseFirestore

struct Player: SenderType {
	var senderId: String
	var displayName: String
	
	var liveCount: Int?
	var animal: Animal?
	var image: UIImage?
	
	static var own = Player(senderId: "self", displayName: "lion")
	
	init(senderId: String, displayName: String) {
		self.senderId = senderId
		self.displayName = displayName
	}
	
	enum PlayerDecodeError: Error {
		case decodeError
	}
	
	init(document: QueryDocumentSnapshot) throws {
		let data = document.data()
		guard let displayName = data["displayName"] as? String,
			  let liveCount   = data["liveCount"] as? Int
		else { throw PlayerDecodeError.decodeError }
		
		self.senderId = document.documentID
		self.displayName = displayName
		self.liveCount = liveCount
	}
}

extension Player: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(animal)
	}
}
