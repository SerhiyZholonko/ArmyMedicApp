//
//  RequestDidSend.swift
//  Dehealth
//
//  Created by apple on 05.02.2024.
//

import UIKit

class RequestDidSend: UIViewController, UITextFieldDelegate {
	//MARK: - Propertis
	private let mainBakgroundView: UIView = {
		let view = UIView()
		view.backgroundColor = "#FFFFFF".hexColor()
		view.layer.cornerRadius = 16
		return view
	}()

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Відновлення паролю"
		label.font = .interMedium(size: 24.0)
		label.setHeight(32)
		return label
	}()
	private let email = "yevgenkaras@dehealth.com"

	private lazy var messageLabel: UILabel = {
		let label = UILabel()
		// Create an attributed string with different fonts for each part
		let attributedText = NSMutableAttributedString(string: "На вашу пошту ")
		let emailFont = UIFont.interMedium(size: 16.0) // Use the desired font for the email part
		let emailAttributedString = NSAttributedString(string: email, attributes: [.font: emailFont])
		attributedText.append(emailAttributedString)
		attributedText.append(NSAttributedString(string: "\n відправлено інструкція з відновлення паролю"))
		label.attributedText = attributedText
		label.textAlignment = .center
		label.numberOfLines = 4
		label.setHeight(92)
		return label
	}()
	private lazy var recoveryButton: TestCustomLoginButton = {
		let button = TestCustomLoginButton()
		button.setTitle("Відновити", for: .normal)
		button.titleLabel?.font = .interMedium(size: 16.0)
		button.backgroundColor = "#5E42EC".hexColor()
		button.layer.cornerRadius = 8
		button.setHeight(48)
		button.addTarget(self, action: #selector(recoveryButtonDidTap), for: .touchUpInside)
		return button
	}()
	private let emailLabel = CustomLabel(textLabel: "Email", textColorLabel: "#333333".hexColor(), fontLabel: .interLight(size: 14.0), alignmentLabel: .left)
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}
	private func configureUI() {
		view.backgroundColor = .clear
		view.addSubview(mainBakgroundView)

		mainBakgroundView.anchor( left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16, height: 279)
		mainBakgroundView.centerY(inView: view)
		mainBakgroundView.addSubview(titleLabel)
		titleLabel.anchor(top: mainBakgroundView.topAnchor, paddingTop: 24)
		titleLabel.centerX(inView: mainBakgroundView)
		mainBakgroundView.addSubview(messageLabel)
		messageLabel.anchor(top: titleLabel.bottomAnchor, left: mainBakgroundView.leftAnchor, right: mainBakgroundView.rightAnchor, paddingTop: 20, paddingLeft: 24, paddingRight: 24)

		mainBakgroundView.addSubview(recoveryButton)
		recoveryButton.anchor(top: messageLabel.bottomAnchor, left: mainBakgroundView.leftAnchor, right: mainBakgroundView.rightAnchor, paddingTop: 20, paddingLeft: 24, paddingRight: 24)
	}

	//MARK: - @objc
	@objc
	private func backButtonTapped() {
		// Handle back button tap event
		dismiss(animated: true)
	}
	@objc
	private func recoveryButtonDidTap() {


	}

}
