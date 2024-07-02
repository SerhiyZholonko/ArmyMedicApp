//
//  ViewController.swift
//  Dehealth
//
//  Created by apple on 05.02.2024.
//

import UIKit


extension UIViewController {
	 func presentAlert(vc: UIViewController) {
		let noInternetAlert = vc
		noInternetAlert.modalPresentationStyle = .fullScreen

		self.present(noInternetAlert, animated: true)
	}
}
