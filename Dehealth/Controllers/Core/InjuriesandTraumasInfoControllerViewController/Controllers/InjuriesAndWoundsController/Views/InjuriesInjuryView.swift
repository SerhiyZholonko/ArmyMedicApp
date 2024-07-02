//
//  InjuriesInjuryView.swift
//  Dehealth
//
//  Created by apple on 26.02.2024.
//

import UIKit

protocol InjuriesInjuryViewDelegate: AnyObject {
	func didTapOnInjuriesView(_ view: InjuriesInjuryView)
}

class InjuriesInjuryView: UIView {
	 //MARK: - Properties
	weak var delegate: InjuriesInjuryViewDelegate?
	private let titleLabel: UILabel = CustomLabel(textLabel: "Title", textColorLabel: .black, fontLabel: .interLight(size: 16), alignmentLabel: .center)
	private var typeInjury: InjuriesInjuryTitle?
	private var typeWeapon: WeaponCausedTheInjuryTitle?
	private let nextButton: UIButton = {
		let image = UIImage(named: "trinagle")
		let button = UIButton(type: .system)
		button.tintColor = .black
		button.setImage(image, for: .normal)
		return button
	}()
	 //MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
		addTapGestuere()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: - Functions
	private func configureUI() {
		backgroundColor = .white
		layer.cornerRadius = 8
		addSubview(titleLabel)
		titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 4, paddingLeft: 16, paddingBottom: 4, height: 24)
		addSubview(nextButton)
		nextButton.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingBottom: 4, paddingRight: 4, width: 24, height: 24)
	}
	private func addTapGestuere() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
		self.addGestureRecognizer(tap)
	}
	public func setTitleInjuryLabel(_ title: InjuriesInjuryTitle) {
		typeInjury = title
		titleLabel.text = title.rawValue
	}
	public func setTitleWeaponLabel(_ title: WeaponCausedTheInjuryTitle) {
		typeWeapon = title
		titleLabel.text = title.rawValue
	}
	public func getTypeInjury() -> InjuriesInjuryTitle? {
		return typeInjury
	}
	public func getTypeWeapon() -> WeaponCausedTheInjuryTitle? {
		return typeWeapon
	}
	public func getTitle() -> String? {
		return titleLabel.text
	}
	
	@objc
	private func didTap() {
		delegate?.didTapOnInjuriesView(self)
	}
}

