//
//  AppDelegate.swift
//  Dehealth
//
//  Created by apple on 25.12.2023.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {	
		return true
	}

	func application(_ application: UIApplication,
					 continue userActivity: NSUserActivity,
					 restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
		if userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL {
			// Handle the URL appropriately within your app
			print("Received a Universal Link: \(url)")
		}
		return true
	}
	
}

