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
	
	weak var delegate: ChatMessagesDelegate?
	
	override init() {
		super.init()
		reference = db.collection("rooms")
		
		let messageListener = reference?
			.document("testRoom")
			.collection("messages")
			.addSnapshotListener { querySnapshot, error in
			guard let snapshot = querySnapshot else {
				print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
				return
			}
			
			snapshot.documentChanges.forEach { change in
				self.handleDocumentChange(change)
			}
		}
	}
	
	func handleDocumentChange(_ change: DocumentChange) {
		guard let message = try? Message(dict: change.document.data()) else { return }
		
		switch change.type {
			case .added: delegate?.receivedMessage(message: message)
			default: break
		}
	}
	
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
	
	func getUsers() {
		guard let reference = reference else { return }
		reference
			.document(roomID!)
			.collection("userData")
			.getDocuments { (querySnapshot, error) in
				guard error == nil else {
					print("Error getting documents: \(error!)")
					return
				}
				
				for document in querySnapshot!.documents {
					let documentData: [String : Any] = document.data()
					//					documentData[""]
				}
			}
	}
	
	func getMessages() async throws -> [Message] {
		guard let snapshot = try await reference?
			.document("testRoom")
			.collection("messages")
			.getDocuments()
		else { return [] }
		return snapshot.documents.compactMap { document in
			try? Message(dict: document.data())
		}
		
	}
	
	func sendMessage(message: Message) {
		guard let messagesCollection = reference?
				.document("testRoom")
				.collection("messages")
		else { return }
		let docReference = messagesCollection.addDocument(data: message.data)
	}
}

extension Network {
	var isRoomDirectory: Bool {
		return reference?.path == "rooms"
	}
}
