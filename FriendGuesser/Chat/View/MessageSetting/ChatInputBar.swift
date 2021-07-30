//
//  ChatInputBar.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/14/21.
//

import Foundation
import UIKit
import InputBarAccessoryView

extension ChatVC: InputBarAccessoryViewDelegate {
	func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
		inputBar.inputTextView.text = ""
		presenter.didTapSendMessage(with: text)
	}
	
	func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
		if presenter.isTyping && text == "" || !presenter.isTyping && text != "" {
			presenter.isTyping.toggle()
		}
	}
	
}
