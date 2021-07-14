//
//  ViewController.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/5/21.
//

import UIKit
import MessageKit
import InputBarAccessoryView



class ChatVC: MessagesViewController {
	
	var presenter: ChatPresenterEvents!
	
	private(set) lazy var refreshControl: UIRefreshControl = {
		let control = UIRefreshControl()
		control.addTarget(self, action: #selector(loadMoreMessages), for: .valueChanged)
		return control
	}()
	
	@objc
	func loadMoreMessages() {}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		presenter = ChatPresenter(view: self)
		configureMessageCollectionView()
		configureInputBarItems()
		configureMessageInputBar()
		
		setTypingIndicatorViewHidden(false, animated: true, whilePerforming: nil, completion: nil)
		
	}
	
	private func configureMessageCollectionView() {
		
		messagesCollectionView.messagesDataSource = self
		messagesCollectionView.messageCellDelegate = self
		messagesCollectionView.messagesLayoutDelegate = self
		messagesCollectionView.messagesDisplayDelegate = self
		
		scrollsToLastItemOnKeyboardBeginsEditing = true // default false
		maintainPositionOnKeyboardFrameChanged = true // default false
		
		showMessageTimestampOnSwipeLeft = true // default false
		
//		messagesCollectionView.refreshControl = refreshControl
		
		guard let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout
		else { return }
		
		layout.setMessageIncomingAvatarSize(.smallTappable)
		layout.setMessageOutgoingAvatarSize(.smallTappable)
		
		layout.sectionInset = UIEdgeInsets(top: 1, left: 8, bottom: 1, right: 8)
		
	}
	
	private func configureMessageInputBar() {
		messageInputBar.delegate = self
		messageInputBar.inputTextView.tintColor = .red
		messageInputBar.sendButton.setTitleColor(.blue, for: .normal)
		messageInputBar.sendButton.setTitleColor(
			UIColor.blue.withAlphaComponent(0.3),
			for: .highlighted
		)
	}
	
	private func configureInputBarItems() {
//		messageInputBar.setRightStackViewWidthConstant(to: , animated: false)
		messageInputBar.sendButton.imageView?.backgroundColor = UIColor(white: 0.85, alpha: 1)
		messageInputBar.sendButton.setSize(.bestTappable, animated: false)
//		messageInputBar.sendButton.image = UIImage(systemName: "paperplane.fill")
		messageInputBar.sendButton.title = "Send"
		messageInputBar.sendButton.imageView?.layer.cornerRadius = 4
		
		// This just adds some more flare
		messageInputBar.sendButton
			.onEnabled { item in
				UIView.animate(withDuration: 0.3, animations: {
					item.imageView?.backgroundColor = .green
				})
			}.onDisabled { item in
				UIView.animate(withDuration: 0.3, animations: {
					item.imageView?.backgroundColor = UIColor(white: 0.85, alpha: 1)
				})
			}
	}
	
}
