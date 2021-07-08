//
//  ChatVCTextView.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/5/21.
//

import Foundation
import UIKit

extension ChatVC: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		guard textView.text.count != 0 else { return }
		
	}
}
