//
//  ChatPresenter.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/9/21.
//

import Foundation
import RxKeyboard
import RxSwift

protocol ChatPresenterProtocol: AnyObject {
	func subscribeKeyboard() -> Void
}

class ChatPresenter {

	private weak var view: ChatViewProtocol!
	
	private let bag = DisposeBag()
	
	init(view: ChatViewProtocol) {
		self.view = view
	}
}

extension ChatPresenter : ChatPresenterProtocol {
	
	func subscribeKeyboard() {
//		RxKeyboard.instance.visibleHeight
//			.drive(onNext: { [toolbar, view] keyboardVisibleHeight in
//				toolbar.frame.origin.y = view.frame.height - toolbar.frame.height - keyboardVisibleHeight
//			})
//			.disposed(by: disposeBag)
		RxKeyboard
			.instance
			.visibleHeight
			.drive(onNext: { [weak self] height in
				self?.view.liftTextInput(on: height)
			}).disposed(by: bag)
	}
	
	
}
