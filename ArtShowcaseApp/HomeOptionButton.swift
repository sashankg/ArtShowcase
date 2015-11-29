//
//  HomeOptionButton.swift
//  ArtShowcaseApp
//
//  Created by Sashank Gogula on 11/22/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation
import UIKit
class HomeOptionButton: UIButton {
	
	let NAVBARHEIGHT: CGFloat = 64
	
	@IBInspectable var menuOption: String!
	
	var option: HomeMenuOptions
		{
			return HomeMenuOptions(rawValue: menuOption)!
	}
	var index: Int {
		get {
			switch option {
			case .Learn: return 0
			case .MeetUp: return 1
			case .Share: return 2
			}
		}
	}
	
	@IBOutlet var verticalConstraint: NSLayoutConstraint!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	func animateOpening(completion: (Bool) -> Void)
	{
		let stackView = superview as! UIStackView
		verticalConstraint.constant = 10
		UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveLinear, animations: {
			self.layoutIfNeeded()
			stackView.spacing = (stackView.frame.height - self.NAVBARHEIGHT * 3)/2
			stackView.layoutIfNeeded()
			}, completion: completion)
		UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: {
			self.frame.origin.y = 0
			}, completion: { _ in  })
	}
	
	func animateHidingForSelected(selected: HomeOptionButton)
	{
		UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseOut, animations: {
			if self.index < selected.index
			{
				self.frame.origin.y = -self.NAVBARHEIGHT
			}
			else
			{
				self.frame.origin.y = self.superview!.frame.height
			}
			}, completion: nil)
	}
	
	func animateRestore()
	{
		self.layoutIfNeeded()
		verticalConstraint.constant = 0
		UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveLinear, animations: {
			self.layoutIfNeeded()
			}, completion: nil)
	}
}