//
//  UIView+Extension.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/5/21.
//

import Foundation
import UIKit

extension UIView {
	@IBInspectable
	var cornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		
		set {
			layer.cornerRadius = newValue
		}
	}
	
	@IBInspectable
	var isCircle: Bool {
		get {
			return cornerRadius == frame.height / 2
		}
		
		set {
			cornerRadius = newValue ? frame.height / 2 : 0
		}
	}
}
