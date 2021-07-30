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
	@IBOutlet weak var avatarImageView: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		avatarImageView.cornerRadius = avatarImageView.frame.width / 2.71
		
		authorize()
		
	
	}
	
	func authorize() {
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
	
	@IBAction func imageViewTapped(_ sender: Any) {
		// https://stackoverflow.com/questions/41717115/how-to-make-uiimagepickercontroller-for-camera-and-photo-library-at-the-same-tim
		Alerts.imagePicker(cameraHandler: { _ in
			self.openCamera()
		}, galleryHandler: { _ in
			self.openGallery()
		}, to: self)
		
	}
	
	@IBAction func enterButton(_ sender: Any) {
		guard let text = nameTextField.text else { return }
		Player.own.displayName = text
		Network.shared.playerEntered(.own)
		
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
// https://stackoverflow.com/questions/41717115/how-to-make-uiimagepickercontroller-for-camera-and-photo-library-at-the-same-tim
extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
	func openGallery() {
		if UIImagePickerController
			.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
			let imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.allowsEditing = true
			imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
			self.present(imagePicker, animated: true, completion: nil)
		}
		else
		{
			let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	func openCamera() {
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
			let imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.sourceType = UIImagePickerController.SourceType.camera
			imagePicker.allowsEditing = false
			self.present(imagePicker, animated: true, completion: nil)
		}
		else
		{
			let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let pickedImage = info[.editedImage] as? UIImage {
			// imageViewPic.contentMode = .scaleToFill
			Network.shared.uploadImage(pickedImage) { url in
				Player.own.imageURL = url
			}
			Player.own.image = pickedImage
			DispatchQueue.main.async {
				self.avatarImageView.image = pickedImage
			}
		}
		picker.dismiss(animated: true, completion: nil)
	}
}

extension ViewController : PresentationDelegatable {}
