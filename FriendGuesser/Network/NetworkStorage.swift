//
//  NetworkStorage.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/28/21.
//

import Foundation
import UIKit
import FirebaseStorage

extension Network {
	func uploadImage(_ image: UIImage, completion: @escaping (URL) -> Void) {
		let ownId: String = Player.own.senderId
		guard let imageData: Data = image.pngData() else { return }
		
		let storage = Storage.storage()
		let storageReference = storage.reference()
		
		let riversRef = storageReference.child("images/\(ownId).jpg")

		let uploadTask = riversRef.putData(imageData, metadata: nil) { _, error in
			riversRef.downloadURL { [weak self] (url, error) in
				
				guard let url = url,
					  let roomID = self?.roomID else {
					return
				}
				
				self?.reference?
					.document(roomID)
					.collection("playerData")
					.document(ownId)
					.updateData(["imageURL": url.absoluteString])
				
				completion(url)
				
			}
		}
		uploadTask.resume()
	}
}
