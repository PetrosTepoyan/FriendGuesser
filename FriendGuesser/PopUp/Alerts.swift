//
//  Alerts.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/15/21.
//

import Foundation
import UIKit

class Alerts {
	
	static func cantEnterRoom() -> UIAlertController {
		let alert = UIAlertController(title: "Can't enter room", message: "There is a problem with sending your data to the server. Contact the developer.", preferredStyle: .alert)
		return alert
	}
}
