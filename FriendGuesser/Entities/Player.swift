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
	var imageURL: URL?
	
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
		
		guard let imageURLString = data["imageURL"] as? String,
			  let imageURL = URL(string: imageURLString),
			  let imageData = try? Data(contentsOf: imageURL),
			  let image = UIImage(data: imageData)
		else { return }
		self.image = image
		self.imageURL = imageURL
		
	}
}

extension Player: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(animal)
	}
}

extension Player: Equatable {
	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.senderId == rhs.senderId
	}
}

// Default data provider
extension Player {
	var skeletonData: [String : Any] { [
		"displayName": displayName,
		"liveCount": 3,
		"isTyping": false,
		"imageURL": imageURL?.absoluteString ?? ""
	]
	}
}
