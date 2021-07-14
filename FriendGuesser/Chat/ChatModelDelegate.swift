//
//  ChatModelDelegate.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/14/21.
//

import Foundation

protocol ChatMessagesReceivable: AnyObject {
	func didEndReceiveing(_ newMessages: [Message])
}

extension ChatModel: ChatMessagesReceivable {
	func didEndReceiveing(_ newMessages: [Message]) {
		messages.append(contentsOf: newMessages)
		view?.reloadData()
	}
}
