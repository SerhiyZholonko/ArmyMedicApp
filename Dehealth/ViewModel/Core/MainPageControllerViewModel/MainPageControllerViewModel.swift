//
//  MainPageControllerViewModel.swift
//  Dehealth
//
//  Created by apple on 29.02.2024.
//

import UIKit

protocol MainPageControllerViewModelPro {
	var soldiers: [String] {get set}
	var isSoldierEmpty: Bool {get}
	func singOut()
}

struct MainPageControllerViewModel: MainPageControllerViewModelPro {
	
	 //MARK: - Properties
	 var soldiers = [String]()
	var isSoldierEmpty: Bool {
		return soldiers.isEmpty
	}

	 //MARK: - Init
	
	
	 //MARK: - Functions
	public func singOut() {
        let storeManager = StorageManager.shared
        storeManager.delete(forKey: .accessToken)
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.configureInitialviewControlr()
              }
	}
	
}
