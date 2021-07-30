//
//  ChatModelDelegate.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/14/21.
//

import Foundation

protocol ChatMessagesReceivable: AnyObject {
	func didEndReceiving(_ newMessages: [Message])
	
	func didEndReceiving(_ players: [Player])
	
	func isTyping(for player: Player, boolValue: Bool)
}

extension ChatModel: ChatMessagesReceivable {
	func didEndReceiving(_ players: [Player]) {
		self.players = Set(players)
	}
	
	func didEndReceiving(_ newMessages: [Message]) {
		messages.append(contentsOf: newMessages)
		view?.reloadData()
	}
	//
	func isTyping(for player: Player, boolValue: Bool) {
		
		switch boolValue {
			case true: typingPlayers.insert(player)
			case false: typingPlayers.remove(player)
		}
		
		if player == .own { // tell to backend
			Network.shared.update(typingStatus: boolValue)
		} else {
			view?.updateTypingIndicator(value: boolValue)
		}
	}
}
