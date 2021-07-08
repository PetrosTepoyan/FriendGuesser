//
//  UIDevice+Extension.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/9/21.
//

import UIKit
// https://stackoverflow.com/questions/52402477/ios-detect-if-the-device-is-iphone-x-family-frameless
extension UIDevice {
	/// Returns `true` if the device has a notch
	var hasNotch: Bool {
		guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
		if UIDevice.current.orientation.isPortrait {
			return window.safeAreaInsets.top >= 44
		} else {
			return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
		}
	}
	
	var bottomSafeAreaHeight: CGFloat {
		guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return 0 }
		return window.safeAreaInsets.bottom
	}
}

