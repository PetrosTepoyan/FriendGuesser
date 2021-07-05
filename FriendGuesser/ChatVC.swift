//
//  ViewController.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/5/21.
//

import UIKit

class ChatVC: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(
			UINib(nibName: MessageCell.identifier, bundle: nil),
			forCellReuseIdentifier: MessageCell.identifier)
	}
	
	
}

extension ChatVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let isOdd = indexPath.row % 2 == 1
		return isOdd ? 300.0 : 140.0
	}
}

extension ChatVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as! MessageCell
		
		let animals = Animal.all
		let isOdd = indexPath.row % 2 == 1
		
		
		cell.coverColor = isOdd ? animals[0].color : animals[1].color
		cell.animalEmoji = isOdd ? animals[0].emoji : animals[1].emoji
		
		
		return cell
	}
	
	
}
