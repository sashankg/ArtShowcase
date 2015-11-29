//
//  ViewController.swift
//  ArtShowcaseApp
//
//  Created by Sashank Gogula on 11/22/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
	static var homeViewController: ViewController!
	@IBOutlet var menuButtons: [HomeOptionButton]!
	@IBOutlet weak var stackView: UIStackView!
	override func viewDidLoad() {
		super.viewDidLoad()
		ViewController.homeViewController = self
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewDidAppear(animated)
		/*let testObject = PFObject(className: "TestObject")
		testObject["foo"] = "bar"
		testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
			print("Object has been saved.")
		}*/
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.

	}

	@IBAction func menuButtonPressed(sender: HomeOptionButton)
	{
		sender.animateOpening { _ in
			self.performSegueWithIdentifier("menuToNavigation", sender: sender)
		}
		for button in menuButtons.filter({ $0 != sender })
		{
			button.animateHidingForSelected(sender)
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let destination = (segue.destinationViewController as? UINavigationController)?.viewControllers[0] as? NavigationViewController
		{
			let button = sender as! HomeOptionButton
			destination.menuOption = button.option
			destination.navigationController?.navigationBar.barTintColor = button.backgroundColor
		}
	}

	func restoreViews()
	{
		if menuButtons[0].frame.height == 64
		{
			UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: {
				self.stackView.spacing = 0
				self.stackView.layoutIfNeeded()
				}, completion: nil)
			for button in menuButtons
			{
				button.animateRestore()
			}
		}
	}
}

enum HomeMenuOptions: String
{
	case Learn = "Learn"
	case MeetUp = "Meet Up"
	case Share = "Share"
}