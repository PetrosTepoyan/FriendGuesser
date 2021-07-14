//
//  MessageBubble.swift
//  FriendGuesser
//
//  Created by Петрос Тепоян on 7/5/21.
//

import Foundation
import UIKit

class MessageBubble: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .clear
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		backgroundColor = .clear
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		let width = rect.width
		let height = rect.height
//		var newRect = rect
//		newRect.origin.x += 4
//		newRect.size.width -= 4
		
//		let p = UIBezierPath(roundedRect: newRect, cornerRadius: 20)
		let p = UIBezierPath()
		
		p.move(to: CGPoint(x: 25, y: height))
		p.addLine(to: CGPoint(x: width - 20, y: height))

		p.addCurve(to: CGPoint(x: width, y: height - 20),
				   controlPoint1: CGPoint(x: width - 8, y: height),
				   controlPoint2: CGPoint(x: width, y: height - 8))
		p.addLine(to: CGPoint(x: width, y: 20))
		p.addCurve(to: CGPoint(x: width - 20, y: 0),
				   controlPoint1: CGPoint(x: width, y: 8),
				   controlPoint2: CGPoint(x: width - 8, y: 0))
		p.addLine(to: CGPoint(x: 21, y: 0))
		p.addCurve(to: CGPoint(x: 4, y: 20),
				   controlPoint1: CGPoint(x: 12, y: 0),
				   controlPoint2: CGPoint(x: 4, y: 8))
		p.addLine(to: CGPoint(x: 4, y: height - 11))
		p.addCurve(to: CGPoint(x: 0, y: height),
				   controlPoint1: CGPoint(x: 4, y: height - 1),
				   controlPoint2: CGPoint(x: 0, y: height))
		p.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
		p.addCurve(to: CGPoint(x: 11.0, y: height - 4.0),
				   controlPoint1: CGPoint(x: 4.0, y: height + 0.5),
				   controlPoint2: CGPoint(x: 8, y: height - 1))
		p.addCurve(to: CGPoint(x: 25, y: height),
				   controlPoint1: CGPoint(x: 16, y: height),
				   controlPoint2: CGPoint(x: 20, y: height))
		
		p.usesEvenOddFillRule = false
		UIColor.systemGray3.setStroke()
		p.stroke()
		UIColor.systemGray3.setFill()
		p.fill()
		backgroundColor = .clear
		layer.backgroundColor = UIColor.clear.cgColor
		setNeedsDisplay()
	}
}
