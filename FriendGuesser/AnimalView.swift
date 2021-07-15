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
	
	init(animal: Animal, frame: CGRect) {
		super.init(frame: frame)
		self.animal = animal
		
		let emojiLabel = UILabel()
		addSubview(emojiLabel)
		
		emojiLabel.font = .systemFont(ofSize: 30)
		emojiLabel.text = animal.emoji
		emojiLabel.textAlignment = .center
		emojiLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			emojiLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
			emojiLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
			emojiLabel.topAnchor.constraint(equalTo: topAnchor),
			emojiLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
		
		layer.cornerRadius = frame.width / 2
		backgroundColor = animal.color
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}
