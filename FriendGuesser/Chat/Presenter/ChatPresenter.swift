//
//  ChatPresenter.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/9/21.
//

import Foundation

class ChatPresenter {
	weak var view: ChatViewDelegate?
	var model: ChatModel!
	
	init(view: ChatViewDelegate) {
		self.view = view
		self.model = ChatModel(view: view)
	}
	
}
