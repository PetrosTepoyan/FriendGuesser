//
//  Network.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/8/21.
//

import Foundation
import FirebaseFirestore

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
	
	private(set) var isLoading: Bool = false
	
	override init() {
		super.init()
		reference = db.collection("rooms")
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
				print(messages)
				self.delegate?.didEndReceiveing(messages)
			}
		
	}
	
//	func handleDocumentChange(_ change: DocumentChange) {
//		switch change.type {
//			case .added:
//				guard let message = try? Message(document: change.document) else { return }
//				// guard message.animal != myAnimal // update through UI
//				delegate?.receivedMessage(message)
//			default: break
//		}
//	}
	
	func newRoom() {
		guard let reference = reference else { return }
		guard isRoomDirectory else { return }
		let documentReference = reference.addDocument(data: ["creation_date" : Date().timeIntervalSince1970])
		roomID = documentReference.documentID
		
		
		reference
			.document(roomID!)
			.collection("messages")
			.addDocument(data: [:])
		
		reference
			.document(roomID!)
			.collection("userData")
			.addDocument(data: [:])
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
