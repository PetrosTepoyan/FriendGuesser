//
//  ViewController.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/5/21.
//

import UIKit

class ChatVC: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var textView: UITextView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(
			UINib(nibName: MessageCell.identifier, bundle: nil),
			forCellReuseIdentifier: MessageCell.identifier)
		
		tableView.estimatedRowHeight = 60.0
		tableView.rowHeight = UITableView.automaticDimension
	}
	
	
}

extension ChatVC: UITableViewDelegate { }

extension ChatVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as! MessageCell
		
		let animal = Animal.all.randomElement()!
		
		cell.coverColor = animal.color
		cell.animalEmoji = animal.emoji
		cell.text = [lorem1, lorem2, lorem3].randomElement()
		
		
		return cell
	}
	
	
}

let lorem1 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

let lorem2 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dum in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

let lorem3 = "has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the"
