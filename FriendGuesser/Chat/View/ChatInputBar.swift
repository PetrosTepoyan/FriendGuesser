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
		presenter.didTapSendMessage(with: text)
	}
	
}
