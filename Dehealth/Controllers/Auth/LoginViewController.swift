//
//  LoginViewController.swift
//  Dehealth
//
//  Created by apple on 25.12.2023.
//

import UIKit
import WebKit


class LoginViewController: UIViewController {

	 //MARK: - Properties
	private var isAlert = false {
		didSet {
			loginView.alpha = isAlert ? 0 : 1
		}
	}
	private var isKeyboardVisible = false
	private var isViewAdjustedForKeyboard = false
	// Add an observer for the isValid property
	private var viewModelObservation: NSKeyValueObservation?
	private var viewModlel = LoginViewControllerViewModel()
	private let bgImage = CustomImageView(image: UIImage(named: "image 19"))
	private let logoImage = CustomImageView(image: UIImage(named: "Logo_main_alt"), width: 230.52, height: 32, background: .clear)
    private let loginView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1402774155, green: 0.1452618241, blue: 0.1919769943, alpha: 1)
        view.layer.cornerRadius = 16
       
        return view
    }()

    private var isWebView: Bool = false
    private lazy var webView: WKWebView = {
        let view = WKWebView(frame: .zero) // You can adjust the frame a
        view.backgroundColor = .red
        view.alpha = isWebView ? 1 : 0
        return view
    }()
	private let enterInSystemLabel = CustomLabel(textLabel: "Вхід в систему", textColorLabel: .white, fontLabel: .interMedium(size: 24.0), alignmentLabel: .center)
	private let loginLabel = CustomLabel(textLabel: "Логін", textColorLabel: "#333333".hexColor(), fontLabel: .interLight(size: 14.0), alignmentLabel: .left)
	private let loginTextField = CustomTextField(placeholder: "", keyboardType: .default, isSecureText: false, borderColor: "#EBEDF5".hexColor(), borderWidth: 1, cornerRadius: 6, textAlignment: .left, customFont: .interMedium(size: 14.0), backgroundColor: "#FAFAFA".hexColor())
	private lazy var loginStack: UIStackView = {
		loginLabel.setHeight(24)
		let sv = UIStackView(arrangedSubviews: [
			loginLabel,
			loginTextField
		])
		sv.axis = .vertical
		sv.distribution = .fillProportionally
		return sv
	}()
	private let passwordLabel = CustomLabel(textLabel: "Пароль", textColorLabel: "#333333".hexColor(), fontLabel: .interLight(size: 14.0), alignmentLabel: .left)
	private let passwordTextField = CustomTextField(placeholder: "", keyboardType: .default, isSecureText: true, borderColor: "#EBEDF5".hexColor(), borderWidth: 1, cornerRadius: 6, textAlignment: .left, customFont: .interMedium(size: 14.0), backgroundColor: "#FAFAFA".hexColor())
	private lazy var passwordStack: UIStackView = {
		passwordLabel.setHeight(24)
		let sv = UIStackView(arrangedSubviews: [
			passwordLabel,
			passwordTextField
		])
		sv.axis = .vertical
		sv.distribution = .fillProportionally
		return sv
	}()
	private lazy var noValidPassword: UIButton  = {
		let button = UIButton(type: .system)
		button.setTitle("Не вірний пароль", for: .normal)
		button.tintColor = "#DB381F".hexColor()
		button.titleLabel?.font = .interMedium(size: 14.0)
		button.setHeight(24)
		button.isHidden = true

		return button
	}()
	private let restorePassword: UIButton  = {
		let button = UIButton(type: .system)
		button.setTitle("Відновити пароль", for: .normal)
		button.tintColor = "#5E42EC".hexColor()
		button.titleLabel?.font = .interMedium(size: 14.0)
		button.setHeight(24)
		return button
	}()
	private lazy var authUnderTextStackView: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [
			noValidPassword,
			restorePassword		])
		sv.axis = .vertical
		sv.distribution = .fillProportionally
		
		return sv
	}()
	private lazy var authStackView: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [
			loginStack,
			passwordStack		])
		sv.axis = .vertical
		sv.distribution = .fillProportionally
		
		return sv
	}()

	private lazy var googleButton: CustomButton = {
        let button =  CustomButton(image: UIImage(named: "icon"), title: "Увійти через Google", tintColor: .black, borderColor: .black, customFont: .interMedium(size: 14.0))
        button.backgroundColor = .white
		button.setHeight(48)
		button.addTarget(self, action: #selector(didTappedGoogle), for: .touchUpInside)
		return button
	}()

	
	 //MARK: - Livecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
        configureWebView()
		configureKeyboardBihaiver()
		configureObservation()
		InternetConnectionManager.shared.delegate = self

	}
	  //MARK: - Func
    private func configureWebView() {
        webView.navigationDelegate = self
    }
	private func configureObservation() {
		// Set up the observer for the isValid property
		viewModelObservation = viewModlel.observe(\.isValid, options: [.new]) { [weak self] (_, change) in
			if let isValid = change.newValue {
				// Update UI based on the new value of isValid
				self?.updateUIForValidity(isValid)
			}
		}
	}



	private func updatePasswordTextFieldAppearance(isValid: Bool) {
		// Update border color based on validity state
		let borderColor = isValid ? "#EBEDF5".hexColor() : "#FF0000".hexColor()
		// Update border color
		passwordTextField.layer.borderColor = borderColor.cgColor
		// Update constraints if needed
		passwordTextField.isValid = isValid
		// Call layoutIfNeeded to immediately apply the changes
		view.layoutIfNeeded()
	}


	private func updateUIForValidity(_ isValid: Bool) {
		// Update your UI elements based on the isValid value
		passwordTextField.isValidPassword(isValid: isValid)
		noValidPassword.setTitle(isValid ? nil : "Не вірний пароль", for: .normal)
		noValidPassword.isHidden = isValid
		// Update constraints and border color for the passwordTextField
		updatePasswordTextFieldAppearance(isValid: isValid)
	}


	private func configureUI() {
		view.addSubview(bgImage)
		bgImage.fillSuperview()
		view.addSubview(logoImage)
		
		var topPadding: CGFloat
		
		if UIScreen.main.bounds.size.height <= 667.0 {
			topPadding = 0.1
		} else if UIScreen.main.bounds.size.height <= 844.0 {
			topPadding = 0.15
		} else {
			topPadding = 0.18
		}
		
		logoImage.centerX(inView: view, topAnchor: view.topAnchor, paddingTop: view.frame.size.height * topPadding)
		
		view.addSubview(loginView)
        loginView.center(inView: view)
        loginView.anchor(width: 358, height: 205)
		loginView.addSubview(enterInSystemLabel)
		enterInSystemLabel.anchor(height: 32)
		enterInSystemLabel.centerX(inView: loginView, topAnchor: loginView.topAnchor, paddingTop: 24)
		loginView.addSubview(googleButton)
        googleButton.setWidth(280)
		googleButton.centerX(inView: view)
        googleButton.centerY(inView: view)
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false // Ensure this is set to false when using auto layout programmatically
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
	}
	private func configureKeyboardBihaiver() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
		view.addGestureRecognizer(tapGestureRecognizer)
	}

	@objc private func didTappedGoogle() {
        isWebView.toggle()
        webView.alpha = isWebView ? 1 : 0
        viewModlel.signInWithCustomAPI(vc: self, webView: webView)
	}

	private func presentAlert() {
		let vc = NoInternetAlert()
		presentAlert(vc: vc)
	}
	@objc private func handleTapGesture () {
		view.endEditing(true)
	}
	@objc private func keyboardWillShow(_ notification: Notification) {
		guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
			return
		}
		
		if !isKeyboardVisible {
			if !isViewAdjustedForKeyboard {
				UIView.animate(withDuration: 0.3) { [weak self] in
					self?.view.frame.origin.y -= 0
                    //keyboardSize.height / 1.5
				}
				isViewAdjustedForKeyboard = true
			}
			isKeyboardVisible = true
		}
	}
	@objc private func keyboardWillHide(_ notification: Notification) {
		if isKeyboardVisible {
			UIView.animate(withDuration: 0.3) { [weak self] in
				self?.view.frame.origin.y = 0
			}
			isViewAdjustedForKeyboard = false
			isKeyboardVisible = false
		}
	}
}



//MARK: - delegate text field

extension LoginViewController: UITextFieldDelegate {

}




 //MARK: - delegate
//
extension LoginViewController: InternetConnectionDelegate {
	func didChangeInternetConnectionStatus(isConnected: Bool) {
		if !isConnected {
			presentAlert()
		}
	}
}


//MARK: - WebView


extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
         guard let url = navigationAction.request.url else {
             decisionHandler(.allow)
             return
         }
         
         if url.absoluteString == "https://armyhealth.org/front/search#" {
             // Retrieve cookies from WKHTTPCookieStore
             webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { [weak self] cookies in
                 if let accessToken = self?.getAccessToken(from: cookies) {
                     if let self = self {
                         self.isWebView.toggle()
                         self.webView.alpha = self.isWebView ? 1 : 0
                         let storeManager = StorageManager.shared
                         let tokenManager = TokenManager.shared
                         storeManager.save(data: accessToken, forKey: .accessToken)
                         tokenManager.saveLastUpdateDate()
                         //redirect to AppDelegate and start func chose VC
                         if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                             sceneDelegate.configureInitialviewControlr()
                               }
                     }
                 } else {
                     print("Access Token not found.")
                 }
             }
         }
         
         decisionHandler(.allow)
     }
    func getAccessToken(from cookies: [HTTPCookie]) -> String? {
        // Iterate through each cookie
        for cookie in cookies {
            // Check if the cookie is the access_token cookie
            if cookie.name == "access_token" {
                // Extract and return the value of the access_token cookie
                return cookie.value
            }
        }
        // Return nil if access token not found
        return nil
    }



}


#Preview {
    LoginViewController()
}
