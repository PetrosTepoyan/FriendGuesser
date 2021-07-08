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
	
	override init() {
		super.init()
		reference = db.collection("rooms")
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
	
	func getMessages() {
		guard let reference = reference else { return }
		reference
			.document("testRoom")
			.collection("messages")
			.getDocuments { (querySnapshot, error) in
				guard error == nil else {
					print("Error getting documents: \(error!)")
					return
				}
				
				let messages: [Message] = querySnapshot!.documents
					.map { document in
						let data: [String : Any] = document.data()
						let text: String = data["text"] as! String
						let animal: Animal = .init(data["animal"] as! String)
						let date: Date = Date(timeIntervalSince1970: data["date"] as! TimeInterval)
						return Message(text: text,
									   animal: animal,
									   date: date)
					}
				print(messages)
			}
	}
}

extension Network {
	var isRoomDirectory: Bool {
		return reference?.path == "rooms"
	}
}
