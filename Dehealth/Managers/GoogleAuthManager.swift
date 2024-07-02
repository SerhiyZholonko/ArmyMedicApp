//
//  GoogleAuthManager.swift
//  Dehealth
//
//  Created by apple on 05.03.2024.
//

import Foundation
import UIKit // Required for using UIViewController, UIApplication
import SafariServices
import WebKit


class GoogleAuthManager {
	// Singleton instance for global access
	static let shared = GoogleAuthManager()

	//  API's base URL
	private let baseURLString = "https://armyhealth.org"

	// Initiates the Google sign-in process
	func signInWithGoogle(from viewController: UIViewController, returnUrl: String) {
		// Construct the URL for the sign-in request
		guard let url = URL(string: "\(baseURLString)/identity/signin-google") else {
			print("Invalid URL")
			return
		}
		//?returnUrl=\(returnUrl)
		// Open the URL in SafariViewController or WKWebView
		let safariVC = SFSafariViewController(url: url)
		viewController.present(safariVC, animated: true)
	}
	// Handles the response from the Google sign-in process
	func handleGoogleSignInResponse(url: URL) {
		// Parse the URL to handle the response
		// This part depends on how your API communicates the result of the sign-in process.
		// Assuming you need to fetch an endpoint to validate the sign-in response.
		validateSignInResponse(url: url)
	}

	// Validates the sign-in response with the server
	private func validateSignInResponse(url: URL) {
		// Here, you might need to extract parameters from the URL and make a GET or POST request to your API
		// Assuming a GET request to /api/v1/identity/google-response or /api/v1/identity/google-response-sync
		// Example:
		guard let validationURL = URL(string: "\(baseURLString)/api/v1/identity/google-response") else {
			print("Invalid validation URL")
			return
		}

		// Perform the request...
		// Handle the response accordingly
	}
	// Function to handle the redirect and extract necessary data
	 func handleRedirect(url: URL) {
		 // Example: Extract data from URL and perform further actions
	 }
    func singInWithGoogleSimple(from viewController: UIViewController, webView: WKWebView) {
           // Initialize WebView
        let customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 15_8 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/120.0.6099.119 Mobile/15E148 Safari/604."

        webView.customUserAgent = customUserAgent

        clearCookiesAndCache()
        //https://armyhealth.org/identity/signin-google
           // Load webpage
           guard let url = URL(string: "https://armyhealth.org/identity/signin-google") else {
               print("Invalid URL")
               return
           }
           let request = URLRequest(url: url)
           webView.load(request)
       }
    private func clearCookiesAndCache() {
          if #available(iOS 9.0, *) {
              let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeCookies, WKWebsiteDataTypeLocalStorage])
              let date = Date(timeIntervalSince1970: 0)
              WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler: {})
          } else {
              let cookieJar = HTTPCookieStorage.shared
              for cookie in cookieJar.cookies ?? [] {
                  cookieJar.deleteCookie(cookie)
              }
          }
      }
}
