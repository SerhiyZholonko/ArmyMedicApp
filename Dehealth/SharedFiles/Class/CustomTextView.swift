//
//  CustomTextView.swift
//  Dehealth
//
//  Created by apple on 15.02.2024.
//

import UIKit

class CustomTextView: UITextView, UITextViewDelegate {

	// Placeholder Label
	private let placeholderLabel: UILabel = UILabel()

	// Placeholder Text
	var placeholder: String = "" {
		didSet {
			placeholderLabel.text = placeholder
		}
	}

	// Placeholder Text Color - Set to gray by default
	var placeholderTextColor: UIColor = .lightGray {
		didSet {
			placeholderLabel.textColor = placeholderTextColor
		}
	}

	override var text: String! {
		didSet {
			textViewDidChange(self)
		}
	}

	// Initialization of the UITextView
	override init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		setupTextView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupTextView()
	}

	// Set up the appearance and behavior of the UITextView
	private func setupTextView() {
		translatesAutoresizingMaskIntoConstraints = false
		updateAppearance()

		// Placeholder setup
		addSubview(placeholderLabel)
		placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
		placeholderLabel.numberOfLines = 0
		placeholderLabel.textColor = placeholderTextColor // Use gray color for placeholder text
		placeholderLabel.text = placeholder
		
		// Constraints for Placeholder Label
		NSLayoutConstraint.activate([
			placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: textPadding.top),
			placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textPadding.left),
			placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textPadding.right),
			placeholderLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -textPadding.bottom)
		])

		delegate = self
	}

	// Update appearance based on the customizable properties
	private func updateAppearance() {
		layer.cornerRadius = cornerRadius
		layer.borderWidth = borderWidth
		layer.borderColor = borderColor.cgColor
		textContainerInset = textPadding
		font = customFont
		textColor = customTextColor
	}

	// UITextViewDelegate method to hide/show placeholder
	func textViewDidChange(_ textView: UITextView) {
		placeholderLabel.isHidden = !textView.text.isEmpty
	}
	
	// UITextViewDelegate method to remove placeholder on begin editing
	func textViewDidBeginEditing(_ textView: UITextView) {
		placeholderLabel.isHidden = true
	}

	// Customizable properties (Include your previous customizations here)
	var cornerRadius: CGFloat = 8
	var borderWidth: CGFloat = 1
	var borderColor: UIColor = "#EBEDF5".hexColor()
	var textPadding: UIEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
	var customFont: UIFont = UIFont.systemFont(ofSize: 16)
	var customTextColor: UIColor = .black
}


