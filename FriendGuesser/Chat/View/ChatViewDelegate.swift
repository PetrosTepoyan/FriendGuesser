//
//  ChatViewDelegate.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/14/21.
//

import Foundation
import UIKit

protocol ChatViewDelegate: AnyObject {
	func reloadData()
}

extension ChatVC: ChatViewDelegate {
	func reloadData() {
		DispatchQueue.main.async {
			self.messagesCollectionView.reloadData()
			self.messagesCollectionView.scrollToLastItem(animated: true)
		}
		
	}
}
