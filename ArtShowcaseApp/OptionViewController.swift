//
//  OptionViewController.swift
//  ArtShowcaseApp
//
//  Created by Sashank Gogula on 11/23/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation
import UIKit

class OptionViewController: UIViewController {
	@IBAction func homeButtonPressed(sender: UIBarButtonItem)
	{
		self.navigationController?.dismissViewControllerAnimated(true) {
			ViewController.homeViewController.restoreViews()
		}
	}
	@IBAction func settingsButtonPressed(sender: UIBarButtonItem) {
		self.navigationController?.performSegueWithIdentifier("settings", sender: self)
	}
}