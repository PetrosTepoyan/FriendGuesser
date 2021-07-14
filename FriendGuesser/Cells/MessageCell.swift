//
//  MessageCell.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/5/21.
//

import Foundation
import UIKit

class MessageCell : UITableViewCell {
	
	@IBOutlet private weak var animalEmojiLabel: UILabel!
	
	@IBOutlet private weak var animalCoverView: UIView!
	@IBOutlet weak var messageTextLabel: UILabel!
	
	static let identifier: String = "MessageCell"
	
	func bind(_ message: Message, isPreviousSameAnimal: Bool = false) {
		if isPreviousSameAnimal {
			animalCoverView.isHidden = true
		} else {
			animalCoverView.backgroundColor = message.animal.color
		}
		
		messageTextLabel.text = message.text
		animalEmojiLabel.text = message.animal.emoji
	}
	
}
