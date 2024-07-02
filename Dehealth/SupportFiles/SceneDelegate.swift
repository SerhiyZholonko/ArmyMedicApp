//
//  SceneDelegate.swift
//  Dehealth
//
//  Created by apple on 25.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		window.makeKeyAndVisible()
		self.window = window
        let tokenManager = TokenManager.shared
        let storeManager = StorageManager.shared
     
        if tokenManager.tokenNeedsUpdate() {
            storeManager.delete(forKey: .accessToken)
        }
		configureInitialviewControlr()

	}
	
	func configureInitialviewControlr() {
		let loginVC = LoginViewController()
		if let accessToken: String = StorageManager.shared.load(forKey: .accessToken)  {
				let conversationVC = MainPageController()
				let nav = UINavigationController(rootViewController: conversationVC)
				self.window?.rootViewController = nav
		} else {
			let nav = UINavigationController(rootViewController: loginVC)
			self.window?.rootViewController = nav
		}
		
	}
}

