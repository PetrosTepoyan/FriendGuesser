//
//  UITableView+Extension.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/5/21.
//

import Foundation
import UIKit

extension UITableView {
	func scrollToBottom() {
		let rowCount: Int = numberOfRows(inSection: 0)
		scrollToRow(at: IndexPath(row: rowCount - 1, section: 0), at: .bottom, animated: true)
	}
	
	func scrollToTop() {
		scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
	}
}

