//
//  ViewController.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/5/21.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

	@IBOutlet weak var animalsCollectionView: UICollectionView!
	@IBOutlet weak var nameTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
			let uid = dataResult.user.uid
			Player.own.senderId = uid
		}
		
	
	}
	@IBAction func enterButton(_ sender: Any) {
		guard let text = nameTextField.text else { return }
		Player.own.displayName = text
		Network.shared.playerEntered(Player.own)
		
		let chatVC = ChatVC()
		navigationController?.pushViewController(chatVC, animated: true)
				
	}
}

extension ViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return Animal.all.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "animalCell", for: indexPath)
		let coverView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
		coverView.backgroundColor = Animal.all[indexPath.row].color
		coverView.layer.cornerRadius = 22
		let emojiLabel = UILabel(frame: coverView.frame)
		emojiLabel.text = Animal.all[indexPath.row].emoji
		emojiLabel.font = UIFont.systemFont(ofSize: 38)
		coverView.addSubview(emojiLabel)
		cell.contentView.addSubview(coverView)
		return cell
	}
}

extension ViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		Player.own.animal = Animal.all[indexPath.row]
	}
}

