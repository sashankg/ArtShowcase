//
//  SettingsViewModel.swift
//  ArtShowcaseApp
//
//  Created by Sashank Gogula on 11/24/15.
//  Copyright © 2015 sashankg. All rights reserved.
//

import Foundation
import ParseFacebookUtilsV4
import Interstellar
class UserViewModel: NSObject {
	
	static var currentUser = UserViewModel()
	
	let accessTokenNotificationSignal: Signal<NSNotification?>
	private var userDataSignal: Signal<NSDictionary>!
	var profilePicSignal: Signal<NSData>!
	override init()
	{
		print("inti")
		accessTokenNotificationSignal = Signal()
		super.init()
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateLogin:", name: FBSDKAccessTokenDidChangeNotification, object: nil)
		
		let tokenSignal = accessTokenNotificationSignal
			.filter(filterOutSameUserID)
			.map { _ in FBSDKAccessToken.currentAccessToken() }
			.startWith(FBSDKAccessToken.currentAccessToken())
			.filter { $0 != nil }
		
		tokenSignal.map { token in
				PFFacebookUtils.logInInBackgroundWithAccessToken(token)
		}
		
		userDataSignal = tokenSignal
			.flatMap { _, update in
				let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email"])
				request.startWithCompletionHandler { _ , result, error in
					if error == nil
					{
						update(.Success(result as! NSDictionary))
					}
					else
					{
						update(.Error(error))
					}
				}
		}

		 profilePicSignal = userDataSignal.flatMap { userData, update in
			let id = userData.objectForKey("id") as! String
			let url = NSURL(string: "https://graph.facebook.com/\(id)/picture?type=large&return_ssl_resources=1")!
			NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, _, error) -> Void in
				if error == nil
				{
					update(.Success(data!))
				}
				else
				{
					update(.Error(error!))
				}
			}).resume()
		}
	}
	
	func updateLogin(notification: NSNotification)
	{
		print("Called")
		accessTokenNotificationSignal.update(notification)
	}
	
	func filterOutSameUserID(notification: NSNotification?) -> Bool
	{
		let userInfo = notification!.userInfo!
		let old = (userInfo[FBSDKAccessTokenChangeOldKey] as? FBSDKAccessToken)?.userID
		let new = (userInfo[FBSDKAccessTokenChangeNewKey] as? FBSDKAccessToken)?.userID
		return old != new
	}
}