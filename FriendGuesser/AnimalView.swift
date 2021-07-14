//
//  AnimalView.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/15/21.
//

import Foundation
import UIKit
import MessageKit

class AnimalView: UIView {
	private var animal: Animal!
	
	func setup(avatarView: AvatarView, animal: Animal) {
		self.animal = animal
		
		let emojiLabel = UILabel()
		avatarView.addSubview(emojiLabel)
		
		emojiLabel.font = .systemFont(ofSize: 30)
		emojiLabel.text = animal.emoji
		emojiLabel.textAlignment = .center
		emojiLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			emojiLabel.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
			emojiLabel.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor),
			emojiLabel.topAnchor.constraint(equalTo: avatarView.topAnchor),
			emojiLabel.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor)
		])
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}
