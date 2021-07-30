//
//  Alerts.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/15/21.
//

import Foundation
import UIKit

class Alerts {
	
	typealias AlertHandler = (UIAlertAction) -> ()
	
	static func cantEnterRoom(to vc: PresentationDelegatable){
		let alert = UIAlertController(title: "Can't enter room", message: "There is a problem with sending your data to the server. Contact the developer.", preferredStyle: .alert)
		vc.presentController(alert)
	}
	
	static func imagePicker(cameraHandler: @escaping AlertHandler,
							galleryHandler: @escaping AlertHandler,
							to vc: PresentationDelegatable) {
		
		let alert = UIAlertController(title: "Choose Image",
									  message: nil,
									  preferredStyle: .actionSheet)
		
		let cameraAction = UIAlertAction(title: "Camera",
										 style: .default,
										 handler: cameraHandler)
		
		let galleryAction = UIAlertAction(title: "Gallery",
										  style: .default,
										  handler: galleryHandler)
		
		let cancelAction = UIAlertAction.init(title: "Cancel",
											  style: .cancel,
											  handler: nil)
		
		alert.addAction(cameraAction)
		alert.addAction(galleryAction)
		alert.addAction(cancelAction)
		
		vc.presentController(alert)
	}
}
