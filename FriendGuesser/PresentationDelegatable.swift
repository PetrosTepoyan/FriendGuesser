//
//  PresentationDelegatable.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/28/21.
//

import Foundation
import UIKit

protocol PresentationDelegatable: UIViewController {
	func presentController(_ vc: UIViewController)
}

extension PresentationDelegatable {
	func presentController(_ vc: UIViewController) {
		present(vc, animated: true, completion: nil)
	}
}
