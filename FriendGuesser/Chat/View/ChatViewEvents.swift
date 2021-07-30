//
//  ChatViewEvents.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/31/21.
//

import Foundation

typealias ChatVCCompositeProtocol = (ChatViewDelegate & ChatViewEvents)

protocol ChatViewEvents {
	func updateTypingIndicator(value: Bool)
}

extension ChatVC : ChatViewEvents {
	func updateTypingIndicator(value: Bool) {
		setTypingIndicatorViewHidden(!value, animated: true)
		messagesCollectionView.scrollToLastItem(at: .top, animated: true)
	}
}
