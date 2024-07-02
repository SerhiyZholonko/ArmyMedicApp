//
//  InjuriesAndTraumasCellHeader.swift
//  Dehealth
//
//  Created by apple on 23.02.2024.
//

import UIKit

protocol InjuriesAndTraumasCellHeaderDelegate: AnyObject {
	func openVCForAddInjuries()
}

class InjuriesAndTraumasCellHeader: UIView {
	 //MARK: - Properties
	weak var delegate: InjuriesAndTraumasCellHeaderDelegate?
    var isInjuries: Bool = false
	let buttonBorderColor = "#8B92AC".hexColor()
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Поранення і травми"
		label.font = .interMedium(size: 18)
		label.setHeight(24)
		return label
	}()
	private lazy var infoLabel: UILabel = {
		let label = UILabel()
        label.text = isInjuries ? "Обов’язково вказати" : ""
		label.font = .interLight(size: 14)
		label.setHeight(24)
		label.textColor = .red
		return label
	}()
	private lazy var titleStackView: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [
			titleLabel,
			infoLabel
		])
		sv.axis = .vertical
		return sv
	}()
	private lazy var markButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Позначити", for: .normal)
		button.tintColor = .black
		button.layer.borderColor = self.buttonBorderColor.cgColor
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 8
		return button
	}()
	 //MARK: -
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
		configureButtons()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: -
	private func configureButtons() {
		markButton.addTarget(self, action: #selector(markTheInjury), for: .touchUpInside)
	}
	private func configureUI() {
		addSubview(titleStackView)
		addSubview(markButton)
		
		markButton.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 6, paddingBottom: 6, width: 107, height: 40)
		
		titleStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: markButton.leftAnchor, paddingTop: 6, paddingBottom: 6, paddingRight: 16 )
	}
	@objc
	private func markTheInjury() {
		delegate?.openVCForAddInjuries()
	}
}
