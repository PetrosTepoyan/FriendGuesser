//
//  ViewController.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/5/21.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
//		let bubble = MessageBubble(frame: CGRect(origin: view.center, size: CGSize(width: 150, height: 80)))
//		bubble.backgroundColor = .clear
//		view.addSubview(bubble)
		let authInstance = Auth.auth()
		authInstance.signInAnonymously { dataResult, error in
			guard error == nil else {
				debugPrint(error!)
				return
			}
			guard let dataResult = dataResult else {
				debugPrint("Data result is nil")
				return
			}
		}
	}


}

