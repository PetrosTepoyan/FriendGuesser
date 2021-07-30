//
//  ChatPresenterEvents.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/14/21.
//

import Foundation
import MessageKit
import UIKit

protocol ChatPresenterEvents: AnyObject {
	func message(for index: Int) -> Message?
	
	func didTapSendMessage(with text: String)
	
	func messageStyle(for index: Int) -> MessageStyle
	
	func messageTopInset(for index: Int) -> CGFloat
	
	func isPrevSameAnimal(for index: Int) -> Bool
	
	var messageCount: Int { get }
	
	var isTyping: Bool { get set }
}

extension ChatPresenter: ChatPresenterEvents {
	
	var messageCount: Int {
		return model.messages.count
	}
	
	var isTyping: Bool {
		get {
			model.typingPlayers.contains(.own)
		}
		set {
			model.isTyping(for: .own, boolValue: newValue)
		}
	}
	
	func message(for index: Int) -> Message? {
		guard index >= 0 && index <= model.messages.count - 1
		else { return nil }
		return model.messages[index]
	}
	
	func didTapSendMessage(with text: String) {
		let message = Message.own(text: text)
		Network.shared.sendMessage(message: message)
	}
	
	func messageStyle(for index: Int) -> MessageStyle {
		let tail = MessageStyle.bubbleTail(.bottomLeft, .curved)
		let round = MessageStyle.bubble
		
		return isNextSameAnimal(for: index) ? round : tail
	}
	
	func messageTopInset(for index: Int) -> CGFloat {
		return isPrevSameAnimal(for: index) ? 0.0 : 15.0
	}
	
	private func isNextSameAnimal(for index: Int) -> Bool {
		guard let message = self.message(for: index),
			  let prevMessage = self.message(for: index + 1)
		else { return false }
		
		return message.animal == prevMessage.animal
	}
	
	func isPrevSameAnimal(for index: Int) -> Bool {
		guard let message = self.message(for: index),
			  let prevMessage = self.message(for: index - 1)
		else { return false }
		
		return message.animal == prevMessage.animal
	}
}
