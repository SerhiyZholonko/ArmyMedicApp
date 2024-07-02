//
//  InternetConnectionManager.swift
//  Dehealth
//
//  Created by apple on 05.02.2024.
//

import Network

protocol InternetConnectionDelegate: AnyObject {
	func didChangeInternetConnectionStatus(isConnected: Bool)
}

class InternetConnectionManager {
	static let shared = InternetConnectionManager()

	private var monitor: NWPathMonitor?
	weak var delegate: InternetConnectionDelegate?

	var isConnected: Bool {
		return monitor?.currentPath.status == .satisfied
	}

	private init() {
		setupNetworkMonitor()
	}

	private func setupNetworkMonitor() {
		monitor = NWPathMonitor()
		monitor?.pathUpdateHandler = { path in
			DispatchQueue.main.async {
				self.handleNetworkChange(path: path)
			}
		}

		let queue = DispatchQueue(label: "InternetConnectionMonitor")
		monitor?.start(queue: queue)
	}

	private func handleNetworkChange(path: NWPath) {
		   if path.status == .satisfied {
			   print("Internet connection is available")
			   delegate?.didChangeInternetConnectionStatus(isConnected: true)
		   } else {
			   print("No internet connection")
			   delegate?.didChangeInternetConnectionStatus(isConnected: false)
		   }
	   }
}

extension InternetConnectionManager {
	func checkCurrentInternetConnectionStatus() -> Bool {
		return monitor?.currentPath.status != .satisfied
	}
}
