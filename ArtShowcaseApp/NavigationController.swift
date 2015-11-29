//
//  NavigationController.swift
//  ArtShowcaseApp
//
//  Created by Sashank Gogula on 11/23/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation
import UIKit
class NavigationViewController: UIViewController {

	var menuOption: HomeMenuOptions!
	
	override func viewWillAppear(animated: Bool) {
		let segue: String
		switch menuOption! {
		case .Learn: segue = "learn"
		case .MeetUp: segue = "meetup"
		case .Share: segue = "share"
		}
		performSegueWithIdentifier(segue, sender: self)
	}
}