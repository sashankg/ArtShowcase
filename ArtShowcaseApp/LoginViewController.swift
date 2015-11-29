//
//  LoginViewController.swift
//  ArtShowcaseApp
//
//  Created by Sashank Gogula on 11/28/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
	func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
	{
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
	{
		
	}

}