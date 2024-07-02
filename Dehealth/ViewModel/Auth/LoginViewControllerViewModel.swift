//
//  LoginViewControllerViewModel.swift
//  Dehealth
//
//  Created by apple on 26.12.2023.
//

import Foundation
import UIKit
import SafariServices
import WebKit

protocol LoginViewControllerViewModelDelegate: AnyObject {
	func isDismissVC(isAuth: Bool)
}

class LoginViewControllerViewModel: NSObject {

	weak var delegate: LoginViewControllerViewModelDelegate?

	@objc dynamic var isValid: Bool = true

	func validatePassword(_ password: String?) {
		// Implement your password validation logic here
		// For example, check if the password meets certain criteria

		if let password = password, password.count >= 6 {
			isValid = true
		} else {
			isValid = false
		}
	}
//	func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
//		authManager.signUp(email: email, password: password) { [weak self] result in
//			guard let self = self else { return }
//			
//			switch result {
//			case .success(let authResult):
//				let newUser = UserDoctor(uid: authResult.uid, email: email)
//				self.firestoreManager.saveUser(newUser) { error in
//					if let error = error {
//						self.isValid = false
//						completion(.failure(error))
//					} else {
//						self.isValid = true
//						completion(.success(()))
//					}
//				}
//			case .failure(let error):
//				self.isValid = false
//				completion(.failure(error))
//			}
//		}
//	}

	public func signInWithCustomAPI(vc: UIViewController, webView: WKWebView) {
		 // Assuming you have a URL to direct users to sign in
		let googleManager = GoogleAuthManager.shared
        googleManager.singInWithGoogleSimple(from: vc, webView: webView)

	 }
	public func signInGoogle(vc: UIViewController) {
		
		
//		guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//		// Create Google Sign In configuration object.
//		let config = GIDConfiguration(clientID: clientID)
//		GIDSignIn.sharedInstance.configuration = config
//
//		// Start the sign in flow!
//		GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [unowned self] result, error in
//			guard error == nil else {
//				// ...
//				return
//			}
//
//			guard let user = result?.user,
//				  let idToken = user.idToken?.tokenString
//			else {
//				// ...
//				return
//			}
// //MARK: - token
//			print(idToken)
//			let credential = GoogleAuthProvider.credential(withIDToken: idToken,
//														   accessToken: user.accessToken.tokenString)
//
//			// Use the Google credential to sign in to Firebase
//			Auth.auth().signIn(with: credential) {[weak self] authResult, error in
//				if let error = error {
//					// Handle Firebase authentication error
//					print("Firebase authentication error: \(error.localizedDescription)")
//					return
//				} else {
//					guard let authResult = authResult, let email = authResult.user.email else { return }
//					self?.firestoreManager.signUpInGoogle(doctor: UserDoctor(uid: authResult.user.uid, email: email)) { error in
//						if let error = error {
//							print(error.localizedDescription)
//						}
//						let scene = UIApplication.shared.connectedScenes.first
//						if let sd: SceneDelegate = (scene?.delegate as? SceneDelegate){
//							sd.configureInitialviewControlr()
//						}
//						self?.delegate?.isDismissVC(isAuth: true)
//					}
//				}
//
//				// User successfully signed in with Google and Firebase
//				// Perform any necessary actions or navigate to the next screen
//			}
			// ...
//		}
	}

}


