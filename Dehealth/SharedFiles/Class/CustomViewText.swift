//
//  File1.swift
//  Dehealth
//
//  Created by apple on 25.12.2023.
//

import UIKit

class CustomViewText: UIView {
	//MARK: - Properties
	private let label: CustomLabel
	private let cornerRadius: CGFloat?
	private let width: CGFloat?
	private let height: CGFloat?
	private let background: UIColor?
	
	//MARK: - Init
	init(backgroundColor: UIColor? = nil, textLabel: String? = nil, cornerRadius: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
		self.label = CustomLabel(textLabel: textLabel ?? "Default Text")
		self.background = backgroundColor
		self.cornerRadius = cornerRadius
		self.width = width
		self.height = height
		super.init(frame: .zero)
		configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Functions
	private func configureUI() {
		addSubview(label)
		label.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			label.centerXAnchor.constraint(equalTo: centerXAnchor),
			label.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
		
		if let backgroundColor = background {
			self.backgroundColor = backgroundColor
		}
		if let cornerRadius = cornerRadius {
			self.layer.cornerRadius = cornerRadius
		}
		if let width = width , let height = height {
			setDimensions(height: height, width: width)
		}
	}
}
