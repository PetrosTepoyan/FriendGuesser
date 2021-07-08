//
//  ViewController.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/5/21.
//

import UIKit
import RxKeyboard

protocol ChatViewProtocol: AnyObject {
	func liftTextInput(on height: CGFloat) -> Void
}

class ChatVC: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
	
	@IBAction func tableViewTouchUpInside(_ sender: Any) {
		view.endEditing(false)
	}
	
	var presenter: ChatPresenterProtocol!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupTableView()
		
		presenter = ChatPresenter(view: self)
		presenter.subscribeKeyboard()
		
		
		
		Network.shared.getMessages()
		createNewRoom()
		
		
//		reference = db.collection("rooms/A94LqvTlNAhARzLRer71/collection_1")
//		reference?.addDocument(data: ["author": "lion",
//									  "text": "Hey, this is me",
//									  "date": 2345678])
//
//		let messageListener = reference?.addSnapshotListener { querySnapshot, error in
//			guard let snapshot = querySnapshot else {
//				print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
//				return
//			}
//
//			snapshot.documentChanges.forEach { change in
//
//				self.handleDocumentChange(change)
//			}
//		}
		
		
		
	}
	
	func createNewRoom() {
		Network.shared.newRoom()
	}
	
	func setupTableView() {
		tableView.register(
			UINib(nibName: MessageCell.identifier, bundle: nil),
			forCellReuseIdentifier: MessageCell.identifier)
		
		tableView.estimatedRowHeight = 60.0
		tableView.rowHeight = UITableView.automaticDimension
		tableView.scrollToBottom()
	}
	
}

extension ChatVC: UITableViewDelegate {
	
}

extension ChatVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as! MessageCell
		
		let animal = Animal.all.randomElement()!
		
		cell.coverColor = animal.color
		cell.animalEmoji = animal.emoji
		cell.text = indexPath.row % 2 == 1 ? "Test" : """
 Lorem ipsum dolor sit amet, consectetur adipiscin elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
"""
		
		return cell
	}
	
	
}

extension ChatVC : ChatViewProtocol {
	func liftTextInput(on height: CGFloat) {
		let bottomSA = UIDevice.current.bottomSafeAreaHeight
		
		let newConstant: CGFloat = height == 0 ? 0 : height - bottomSA
		
		UIView.animate(withDuration: 0.2) {
			self.textViewBottomConstraint.constant = newConstant
			self.view.layoutIfNeeded()
		}
		
	}
}

let lorem1 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

let lorem2 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dum in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

let lorem3 = "has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the"
