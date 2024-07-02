//
//  CustomLoginButton.swift
//  Dehealth
//
//  Created by apple on 26.12.2023.
//

import UIKit


class CustomLoginButton: UIButton {
	// MARK: - Properties
	private let spacing: CGFloat = 8.0

	// MARK: - Init
	init(image: UIImage? = nil, title: String?, tintColor: UIColor = .black, borderColor: UIColor? = nil, customFont: UIFont? = nil) {
		super.init(frame: .zero)
		
		imageView?.contentMode = .scaleAspectFit
		setImage(image, for: .normal)
		setTitleColor(tintColor, for: .normal)
		setTitle(title, for: .normal)
		
		if let customFont = customFont {
			titleLabel?.font = customFont
		} else {
			titleLabel?.font = UIFont.systemFont(ofSize: 16.0) // Default font size
		}
		
		contentHorizontalAlignment = .center // Center alignment
		imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
		titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
		
		layer.cornerRadius = 8.0
		layer.borderWidth = 1.0
		if let borderColor = borderColor {
			layer.borderColor = borderColor.cgColor
		}
		backgroundColor = UIColor.clear
		
		addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Action
	@objc private func buttonTapped() {
		// Show the ProgressHUD with an image and message
//		ProgressHUD.banner("Banner title", "Banner message to display.")
		// Handle button tap event (if needed)
		// ...
	}
}



