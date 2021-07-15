//
//  Message.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/9/21.
//

import Foundation
import MessageKit
import FirebaseFirestore

struct Message: MessageType {
	var sender: SenderType
	var messageId: String
	var sentDate: Date
	var kind: MessageKind
	var animal: Animal
	var text: String
	
	static let none = Message()
	
	static func own(text: String) -> Message {
		return Message(sender: Player.own,
					   messageId: "",
					   sentDate: Date(),
					   animal: Player.own.animal ?? .none,
					   text: text)
	}
	
	enum MessageDecodeError: Error {
		case decodeError
	}
	
	init(document: QueryDocumentSnapshot) throws {
		let data = document.data()
		guard let text = data["text"] as? String,
			  let animalString = data["animal"] as? String,
			  let timeInterval = data["date"] as? TimeInterval
		else { throw MessageDecodeError.decodeError }
		
		
		self.messageId = document.documentID
		self.sender = Player(senderId: animalString, displayName: animalString)
		self.sentDate = Date(timeIntervalSince1970: timeInterval)
		self.kind = .text(text)
		self.text = text
		self.animal = Animal(animalString)
	}
	
	internal init(sender: SenderType, messageId: String, sentDate: Date, animal: Animal, text: String) {
		self.sender = sender
		self.messageId = messageId
		self.sentDate = sentDate
		self.kind = .text(text)
		self.animal = animal
		self.text = text
	}
	
	
	
	init() {
		self.sender = Player(senderId: "", displayName: "")
		self.messageId = ""
		self.sentDate = Date()
		self.kind = .text("")
		self.animal = .rabbit
		self.text = "Empty message. Check datasource"
	}
	
	var data: [String : Any] {
		return ["text" : text,
				"animal" : animal.name,
				"date": sentDate.timeIntervalSince1970]
	}
	
}
