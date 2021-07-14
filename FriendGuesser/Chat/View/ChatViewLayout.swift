//
//  ChatViewLayout.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/14/21.
//

import Foundation
import UIKit
import MessageKit

extension ChatVC: MessagesLayoutDelegate {
	func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
		return presenter.messageTopInset(for: indexPath.section)
	}
}
