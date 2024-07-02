//
//  RecaveryPassword.swift
//  Dehealth
//
//  Created by apple on 02.02.2024.
//

import UIKit

class RecaveryPasswordClass: UIViewController, UITextFieldDelegate {
     //MARK: - Propertis
	private lazy var backButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(named: "Vector"), for: .normal)
		button.setTitle("Назад", for: .normal)
		button.tintColor = "#5E42EC".hexColor()

		button.setTitleColor("#5E42EC".hexColor(), for: .normal)
		button.titleLabel?.font = .interMedium(size: 14.0)

		button.semanticContentAttribute = .forceLeftToRight
		button.contentHorizontalAlignment = .left

		// Add spacing between image and title
		let spacing: CGFloat = 8
		button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing, bottom: 0, right: spacing)
		button.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: -spacing)

		button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
		button.setHeight(40)
		return button
	}()
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Відновлення паролю"
		label.font = .interMedium(size: 24.0)
		label.setHeight(32)
		return label
	}()
	private let messageLabel: UILabel = {
		let label = UILabel()
		label.text = "Вкажіть email щоб надіслати запит на відновлення паролю"
		label.font = .interLight(size: 16.0)
		label.textAlignment = .center
		label.numberOfLines = 2
		label.setHeight(48)
		return label
	}()
	private lazy var recoveryButton: TestCustomLoginButton = {
		let button = TestCustomLoginButton()
		button.setTitle("Відновити", for: .normal)
		button.titleLabel?.font = .interMedium(size: 16.0)
		button.backgroundColor = "#BB9FF8".hexColor()
		button.layer.cornerRadius = 8
		button.setHeight(48)
		button.addTarget(self, action: #selector(recoveryButtonDidTap), for: .touchUpInside)
		return button
	}()
	private let emailLabel = CustomLabel(textLabel: "Email", textColorLabel: "#333333".hexColor(), fontLabel: .interLight(size: 14.0), alignmentLabel: .left)
	private let emailTextField = CustomTextField(placeholder: "", keyboardType: .default, isSecureText: false, borderColor: "#EBEDF5".hexColor(), borderWidth: 1, cornerRadius: 6, textAlignment: .left, customFont: .interMedium(size: 14.0), backgroundColor: "#FAFAFA".hexColor())
	private lazy var emailStack: UIStackView = {
		emailLabel.setHeight(24)
		let sv = UIStackView(arrangedSubviews: [
			emailLabel,
			emailTextField
		])
		sv.axis = .vertical
		sv.distribution = .fillProportionally
		return sv
	}()
	private let mainBakgroundView: UIView = {
		let view = UIView()
		view.backgroundColor = "#FFFFFF".hexColor()
		view.layer.cornerRadius = 16
		return view
	}()
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		configureTextField()
	}
	private func configureUI() {
		let halfScreenHeight = view.frame.height * 0.4
		view.backgroundColor = .clear
		view.addSubview(mainBakgroundView)
		
		mainBakgroundView.anchor( left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16, height: 380)
		mainBakgroundView.centerY(inView: view)
		mainBakgroundView.addSubview(backButton)
		backButton.anchor(top: mainBakgroundView.safeAreaLayoutGuide.topAnchor, left: mainBakgroundView.leftAnchor, paddingTop: 24, paddingLeft: 24)
		mainBakgroundView.addSubview(titleLabel)
		titleLabel.anchor(top: backButton.bottomAnchor, paddingTop: 20)
		titleLabel.centerX(inView: mainBakgroundView)
		mainBakgroundView.addSubview(messageLabel)
		messageLabel.anchor(top: titleLabel.bottomAnchor, left: mainBakgroundView.leftAnchor, right: mainBakgroundView.rightAnchor, paddingTop: 20, paddingLeft: 24, paddingRight: 24)
		mainBakgroundView.addSubview(emailStack)
		emailStack.anchor(top: messageLabel.bottomAnchor, left: mainBakgroundView.leftAnchor, right: mainBakgroundView.rightAnchor, paddingTop: 20, paddingLeft: 24, paddingRight: 24)
		mainBakgroundView.addSubview(recoveryButton)
		recoveryButton.anchor(top: emailStack.bottomAnchor, left: mainBakgroundView.leftAnchor, right: mainBakgroundView.rightAnchor, paddingTop: 20, paddingLeft: 24, paddingRight: 24)
	}
	private func configureTextField() {
		emailTextField.delegate = self
		emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)

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
	@objc
	private func emailTextFieldDidChange() {
		guard let isEmpty = emailTextField.text?.isEmpty else { return }
		recoveryButton.backgroundColor = isEmpty ? "#BB9FF8".hexColor() : "#5E42EC".hexColor()
	}
}
