//
//  Network.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/8/21.
//

import Foundation
import FirebaseFirestore
import UIKit

class Network: NSObject {
	static var shared = Network()
	
	private let db = Firestore.firestore()
	private var reference: CollectionReference?
	
	private var roomID: String?
	private var roomPath: String? {
		guard let roomID = roomID else { return nil }
		return "rooms/" + roomID
	}
	
	weak var delegate: ChatMessagesReceivable?
	
	var messageListener: ListenerRegistration!
	var playerListener: ListenerRegistration!
	
	private(set) var isLoading: Bool = false
	
	override init() {
		super.init()
		reference = db.collection("rooms")
		roomID = "testRoom"
	}
	
	deinit {
		messageListener.remove()
	}
	
	func subscribeForMessages() {
		messageListener = reference?
			.document("testRoom")
			.collection("messages")
			.order(by: "date")
			.addSnapshotListener { querySnapshot, error in
				guard let messages = querySnapshot?.documentChanges.compactMap({
					return try? Message(document: $0.document)
				})
				else { return }
				self.delegate?.didEndReceiving(messages)
			}
	}
	
	func subscribeForUsers() {
		playerListener = reference?
			.document("testRoom")
			.collection("playerData")
			.addSnapshotListener { querySnapshot, error in
				var players: [Player] = []
				querySnapshot?.documentChanges.forEach {
					guard let player = try? Player(document: $0.document) else { return }
					switch $0.type {
						case .modified:
							let isTyping = $0.document.data()["isTyping"] as! Bool
							self.delegate?.isTyping(for: player, boolValue: isTyping)
							
						case .added:
							players.append(player)
							
						case .removed: ()
					}
					guard !players.isEmpty else { return }
					self.delegate?.didEndReceiving(players)
				}
			}
	}
	
	func newRoom() {
		guard let reference = reference else { return }
		guard isRoomDirectory else { return }
		let documentReference = reference.addDocument(data: ["creation_date" : Date().timeIntervalSince1970])
		roomID = documentReference.documentID
		
//		reference
//			.document(roomID!)
//			.collection("messages")
//			.addDocument(data: [:])
//		
//		reference
//			.document(roomID!)
//			.collection("userData")
//			.addDocument(data: [:])
	}
	
	func playerEntered(_ player: Player) {
		guard let reference = reference else { return }
		guard isRoomDirectory else { return }
		// uploadPicture and get its address.
		
		var data: [String : Any] = [
			"displayName": player.displayName,
			"liveCount": 3,
			"isTyping": false
		]
		
		if let animal = player.animal { data["animal"] = animal.name }
		
		reference
			.document(roomID!)
			.collection("playerData")
			.document(player.senderId)
			.setData(data)

	}
	
	func playerLeft(_ player: Player) {
		guard let reference = reference else { return }
		guard isRoomDirectory else { return }
		
		reference
			.document(roomID!)
			.collection("playerData")
			.document(player.senderId)
			.delete()
		
	}
	
	func sendMessage(message: Message) {
		guard let messagesCollection = reference?
				.document("testRoom")
				.collection("messages")
		else { return }
		messagesCollection.addDocument(data: message.data)
	}
}

extension Network {
	var isRoomDirectory: Bool {
		return reference?.path == "rooms"
	}
}
