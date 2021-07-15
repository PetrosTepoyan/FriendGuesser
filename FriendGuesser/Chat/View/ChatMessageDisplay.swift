//
//  ChatMessageDisplay.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/14/21.
//

import Foundation
import UIKit
import MessageKit

extension ChatVC: MessagesDisplayDelegate {
	func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
		guard let message = presenter.message(for: indexPath.section) else { return }
		avatarView.setCorner(radius: CGSize.smallTappable.width / 2)
		avatarView.backgroundColor = message.animal.color
		avatarView.placeholderFont = .systemFont(ofSize: 30)
		avatarView.initials = message.animal.emoji
		
		
	}
	
	func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
		
		return .systemBlue
	}
	
	func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
		
		return presenter.messageStyle(for: indexPath.section)
	}
	
	
}
