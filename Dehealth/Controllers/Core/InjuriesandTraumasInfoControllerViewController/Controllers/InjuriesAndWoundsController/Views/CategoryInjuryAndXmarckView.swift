//
//  CategoryInjuryAndXmarckView.swift
//  Dehealth
//
//  Created by apple on 28.02.2024.
//

import UIKit

protocol CategoryInjuryAndXmarckViewDelegate: AnyObject {
	func closeAction()
}

class CategoryInjuryAndXmarckView: UIView {
	 //MARK: - Properties
	weak var delegate: CategoryInjuryAndXmarckViewDelegate?
	private let titleLabel = CustomLabel(textLabel: "", textColorLabel: .black, fontLabel: .interLight(size: 16))
	private lazy var closeButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(named: "xmark2"), for: .normal)
		button.tintColor = .black
		button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
		return button
	}()
	 //MARK: -
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: -
	private func configureUI() {
		backgroundColor = .white
		layer.cornerRadius = 8
		addSubview(titleLabel)
		addSubview(closeButton)
		self.setHeight(32)
		closeButton.anchor(right: rightAnchor, paddingRight: 8, width: 18, height: 18)
		closeButton.centerY(inView: self)
		titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: closeButton.leftAnchor, paddingTop: 4, paddingLeft: 16, paddingBottom: 4, paddingRight: 16, height: 24)
	}
	public func setCategoryTitle(_ title: String) {
		titleLabel.text = title
	}
	
	@objc
	private func didTapClose() {
		delegate?.closeAction()
	}
}
