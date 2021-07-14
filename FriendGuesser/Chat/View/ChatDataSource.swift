//
//  ChatDataSource.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/14/21.
//

import UIKit
import MessageKit

extension ChatVC: MessagesDataSource {
	func currentSender() -> SenderType {
		return AppDelegate.user
	}
	
	func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
		guard let message = presenter.message(for: indexPath.section) else {
			return Message.none
		}
		
		return message
	}
	
	func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
		presenter.messageCount
	}
}
