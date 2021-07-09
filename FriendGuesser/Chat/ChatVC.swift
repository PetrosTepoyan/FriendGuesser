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

protocol ChatMessagesDelegate: AnyObject {
	func receivedMessage(message: Message)
}

class ChatVC: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
	
	@IBAction func tableViewTouchUpInside(_ sender: Any) {
		view.endEditing(false)
	}
	@IBAction func sendButtonTouchUpInside(_ sender: Any) {
		guard let text = textView.text, text != "" else { return }
		let myAnimal: Animal = .unicorn
		let newMessage: Message = .init(text: text, animal: myAnimal, date: Date())
		Network.shared.sendMessage(message: newMessage)
	}
	
	var messages: [Message] = [] {
		didSet {
			tableView.reloadData()
		}
	}
	
	var presenter: ChatPresenterProtocol!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		Network.shared.delegate = self
		setupTableView()
		
		presenter = ChatPresenter(view: self)
		presenter.subscribeKeyboard()
		
		if #available(iOS 15.0, *) {
			async {
				self.messages = try await Network.shared.getMessages()
			}
		} else {
			// Fallback on earlier versions
		}
		
		
		
		createNewRoom()
		
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
		return messages.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as! MessageCell
		
		let message = messages[indexPath.row]
		cell.text = message.text
		cell.coverColor = message.animal.color
		cell.animalEmoji = message.animal.emoji
		
		
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

extension ChatVC: ChatMessagesDelegate {
	func receivedMessage(message: Message) {
		messages.append(message)
	}
}

let lorem1 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

let lorem2 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dum in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

let lorem3 = "has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the"
