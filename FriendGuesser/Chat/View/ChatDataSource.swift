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
		return Player.own
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
	
	func typingIndicator(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UICollectionViewCell {
		let cell = messagesCollectionView.dequeueReusableCell(TypingIndicatorCell.self, for: indexPath)
		let smallAnimal = AnimalView(animal: .lion, frame: CGRect(x: 0, y: 0, width: 10, height: 10))
		smallAnimal.translatesAutoresizingMaskIntoConstraints = false
		cell.contentView.addSubview(smallAnimal)
		NSLayoutConstraint.activate([
			smallAnimal.widthAnchor.constraint(equalToConstant: 40),
			smallAnimal.heightAnchor.constraint(equalToConstant: 40),
			smallAnimal.leadingAnchor.constraint(equalTo: cell.typingBubble.trailingAnchor, constant: 10),
			smallAnimal.centerYAnchor.constraint(equalTo: cell.typingBubble.centerYAnchor)
		])
		return cell
	}
}
