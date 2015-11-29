//
//  SettingsViewController.swift
//  ArtShowcaseApp
//
//  Created by Sashank Gogula on 11/24/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation
import UIKit

class UserViewController: UIViewController
{
	@IBOutlet weak var profileNameLabel: UILabel!
	@IBOutlet weak var profileImageView: UIImageView!
	var viewModel: UserViewModel!
	
	override func viewDidLoad() {
		viewModel = UserViewModel.currentUser
		//viewModel.loginSignal.next { token in
		//}
		
		viewModel.profilePicSignal.next { data in
			NSOperationQueue.mainQueue().addOperationWithBlock {
				let image = UIImage(data: data)
				self.profileImageView.image = image
				//self.profileImageView.setNeedsDisplay()
			}
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		performSegueWithIdentifier("login", sender: self)

	}
}