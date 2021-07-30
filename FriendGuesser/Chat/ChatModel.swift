//
//  ChatModel.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/9/21.
//

import Foundation

class ChatModel {
	
	var messages: [Message] = []
	var typingPlayers: Set<Player> = []
	var players: Set<Player> = []
	weak var view: ChatVCCompositeProtocol?
	
	init(view: ChatVCCompositeProtocol) {
		self.view = view
		Network.shared.delegate = self
		Network.shared.subscribeForMessages()
		Network.shared.subscribeForUsers()
	}
}
