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
	
	static let identifier: String = "MessageCell"
	
	var animalEmoji: String? {
		get {
			animalEmojiLabel.text
		}
		
		set {
			animalEmojiLabel.text = newValue
		}
	}
	
	var coverColor: UIColor? {
		get {
			animalCoverView.backgroundColor
		}
		
		set {
			animalCoverView.backgroundColor = newValue
		}
	}
	
}
