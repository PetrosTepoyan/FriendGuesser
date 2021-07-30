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
	
	private(set) lazy var questionView: UIView = .init()
	var questionInitialCenter: CGPoint = .zero
	
	@objc
	func loadMoreMessages() {}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		presenter = ChatPresenter(view: self)
		configureMessageCollectionView()
		configureInputBarItems()
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
		layout.textMessageSizeCalculator.messageLabelFont = UIFont(name: "Nunito", size: 18)!
		layout.setMessageIncomingAvatarSize(.smallTappable)
		layout.setMessageOutgoingAvatarSize(.smallTappable)
		layout.setMessageIncomingMessagePadding(UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0))
//		layout.messagesCollectionView.messagesDisplayDelegate.color
		layout.setMessageOutgoingMessagePadding(UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0))
		
		layout.sectionInset = UIEdgeInsets(top: 1, left: 8, bottom: 1, right: 8)
		
	}
	
	private func configureInputBarItems() {
		let circleColor: UIColor = Player.own.animal?.color ?? .red
		let symbolConfiguration = UIImage.SymbolConfiguration(weight: .heavy)
		let bounceAnimator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 0.8, animations: nil)
		let debounceAnimator = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 0.8, animations: nil)
		
		messageInputBar.setRightStackViewWidthConstant(to: CGSize.bestTappable.width, animated: false)
		messageInputBar.sendButton.configure {
			$0.setSize(.bestTappable, animated: false)
			$0.isEnabled = false
			$0.image = UIImage(systemName: "arrow.up", withConfiguration: symbolConfiguration) // UIImage(systemName: "paperplane.fill")
			$0.title = nil
			$0.tintColor = .white
			$0.backgroundColor = circleColor
			$0.clipsToBounds = true
			$0.layer.cornerRadius = CGSize.bestTappable.width / 2
		}
		.onEnabled { item in
			UIView.animate(withDuration: 0.3, animations: {
				item.backgroundColor = circleColor
			})
		}.onDisabled { item in
			UIView.animate(withDuration: 0.3, animations: {
				item.backgroundColor = circleColor.withAlphaComponent(0.7)
			})
		}
		.onKeyboardEditingBegins { item in
			bounceAnimator.addAnimations {
				item.transform = item.transform.rotated(by: .pi/4)
			}
			
			debounceAnimator.addAnimations {
				item.transform = .identity
			}
			
			bounceAnimator.addCompletion { position in
				guard position == .end else { return }
				debounceAnimator.startAnimation()
			}
			
			bounceAnimator.startAnimation()
		}
		
		
		messageInputBar.delegate = self
	}
	
}
