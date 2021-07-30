//
//  QuestionPanGesture.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/17/21.
//

import Foundation
import UIKit

extension ChatVC {
	@objc
	func panGesture(_ sender: UIPanGestureRecognizer) {
		switch sender.state {
			case .began:
				questionInitialCenter = questionView.center
			case .changed:
				let translation = sender.translation(in: view)
				
				questionView.center = CGPoint(x: questionInitialCenter.x + translation.x,
											  y: questionInitialCenter.y + translation.y)
			case .ended,
				 .cancelled:
				UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
					// check
				}
			default:
				break
		}
	}
}
