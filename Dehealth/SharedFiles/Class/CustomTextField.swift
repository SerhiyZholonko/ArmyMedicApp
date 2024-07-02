//
//  File.swift
//  Dehealth
//
//  Created by apple on 25.12.2023.
//

import UIKit

class CustomTextField: UITextField {
	// MARK: - Properties
	private let imagePadding: CGFloat
	// Default left padding
	private let defaultLeftPadding: CGFloat = 16.0
	
	private lazy var secureModeImage: UIImage? = UIImage(named: "Union")
	 lazy var isValid: Bool = true
	private lazy var toggleButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(isSecureTextEntry ? secureModeImage : nil, for: .normal)
		button.contentMode = .center
		button.tintColor = .black
		button.frame = CGRect(x: 0, y: 0, width: defaultLeftPadding, height: self.frame.size.height)
		button.addTarget(self, action: #selector(toggleSecureMode), for: .touchUpInside)
		button.setWidth(60)
		return button
	}()
	
	// MARK: - Init
	init(placeholder: String, keyboardType: UIKeyboardType = .default, isSecureText: Bool = false, borderColor: UIColor? = nil, borderWidth: CGFloat? = nil, cornerRadius: CGFloat? = nil, leftImage: UIImage? = nil, imagePadding: CGFloat = 0, textAlignment: NSTextAlignment = .left, customFont: UIFont? = nil, backgroundColor: UIColor? = nil) {
		self.imagePadding = imagePadding
		
		super.init(frame: .zero)
		borderStyle = .none
		textColor = .label
		keyboardAppearance = .light
		clearButtonMode = .whileEditing
		setHeight(50)
		
		if let customFont = customFont {
			font = customFont
		} else {
			font = UIFont.systemFont(ofSize: 14.0) // Default font size
		}
		
		let leftContainerView = UIView(frame: CGRect(x: 0, y: 0, width: imagePadding + (leftImage?.size.width ?? 0), height: self.frame.size.height))
		
		if let leftImage = leftImage {
			let leftImageView = UIImageView(image: leftImage)
			leftImageView.contentMode = .center
			leftImageView.tintColor = .systemOrange
			leftImageView.frame = CGRect(x: imagePadding, y: 0, width: leftImage.size.width, height: self.frame.size.height)
			leftContainerView.addSubview(leftImageView)
		}
		
		if isSecureText {
			rightViewMode = .always
			toggleButton.frame = CGRect(x: 0, y: 0, width: defaultLeftPadding + 30, height: self.frame.size.height)
			rightView = toggleButton
		}
		
		leftViewMode = .always
		leftView = leftContainerView
		
		self.placeholder = placeholder
		self.keyboardType = keyboardType
		self.isSecureTextEntry = isSecureText
		if let borderColor = borderColor {
			layer.borderColor = borderColor.cgColor
		}
		if let borderWidth = borderWidth {
			layer.borderWidth = borderWidth
		}
		if let cornerRadius = cornerRadius {
			layer.cornerRadius = cornerRadius
		}
		if let backgroundColor = backgroundColor {
			self.backgroundColor = backgroundColor
		}
		self.textAlignment = textAlignment
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Functions
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: imagePadding + defaultLeftPadding, dy: 0)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: imagePadding + defaultLeftPadding, dy: 0)
	}
	
	override var isSecureTextEntry: Bool {
		didSet {
			toggleButton.setImage(isSecureTextEntry ? secureModeImage : nil, for: .normal)
		}
	}
	func isValidPassword(isValid: Bool) {
		layer.borderColor = isValid ? layer.borderColor : "#DB381F".hexColor().cgColor
	}
	
	//Не вірний пароль
	@objc private func toggleSecureMode() {
		isSecureTextEntry.toggle()
		toggleButton.setImage(isSecureTextEntry ? secureModeImage : secureModeImage, for: .normal)
	}
}

