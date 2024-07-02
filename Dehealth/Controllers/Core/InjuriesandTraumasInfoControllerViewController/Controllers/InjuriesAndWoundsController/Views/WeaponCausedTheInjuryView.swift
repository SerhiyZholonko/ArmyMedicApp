//
//  File.swift
//  Dehealth
//
//  Created by apple on 28.02.2024.
//

import UIKit

protocol WeaponCausedTheInjuryViewDelegate: AnyObject {
	func closeViewAction()
	func presentVC(weapontype: WeaponCausedTheInjuryTitle, injuriesInjuryType: InjuriesInjuryTitle)
}
//weapon caused the injury
class WeaponCausedTheInjuryView: UIView {
	 //MARK: - Properties
	weak var delegate: WeaponCausedTheInjuryViewDelegate?
	private var injuriesInjuryType: InjuriesInjuryTitle?
	private lazy var categoryView: CategoryInjuryAndXmarckView = {
		let view = CategoryInjuryAndXmarckView()
		view.setCategoryTitle("Осколкове")
		view.delegate = self
		return view
	}()
	private var whatKindOfWeaponLabel: UILabel = {
		let label = UILabel()
		label.font = .interMedium(size: 16)
		label.text = "Якою зброєю було спричинено?"
		label.setHeight(24)
		return label
	}()
	
	//type of weapon
	private lazy var leftTypeOfWeaponStakView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			typeOfWeapon,
			typeOfWeapon2,
			typeOfWeapon3,
			typeOfWeapon4,
			typeOfWeapon5
		])
		stackView.axis = .vertical
		stackView.distribution = .fillProportionally
		stackView.spacing = 8
		return stackView
	}()
	private lazy var rightTypeOfWeaponStakView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [
			typeOfWeapon6,
			typeOfWeapon7,
			typeOfWeapon8,
			typeOfWeapon9
		])
		stackView.axis = .vertical
		stackView.distribution = .fillProportionally
		stackView.spacing = 8
		return stackView
	}()
	private lazy var typeOfWeapon:  InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleWeaponLabel(.smallArms)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var typeOfWeapon2:  InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleWeaponLabel(.artillery)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var typeOfWeapon3:  InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleWeaponLabel(.rocket)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var typeOfWeapon4:  InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleWeaponLabel(.fpvDrone)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var typeOfWeapon5:  InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleWeaponLabel(.tank)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var typeOfWeapon6:  InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleWeaponLabel(.aviation)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var typeOfWeapon7:  InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleWeaponLabel(.grenadeLauncher)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var typeOfWeapon8:  InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleWeaponLabel(.mine)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var typeOfWeapon9:  InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleWeaponLabel(.flamethrower)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	 //MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: - Functions
	private func configureUI() {
		backgroundColor = .secondarySystemBackground
		addSubview(categoryView)
		addSubview(whatKindOfWeaponLabel)
		addSubview(leftTypeOfWeaponStakView)
		addSubview(rightTypeOfWeaponStakView)
		categoryView.anchor(top: topAnchor, left: leftAnchor, paddingLeft: 16, width: 149)
		whatKindOfWeaponLabel.anchor(top: categoryView.bottomAnchor, left: leftAnchor, right: rightAnchor,
									 paddingTop: 24, paddingLeft: 16, paddingRight: 16)
		leftTypeOfWeaponStakView.anchor(top: whatKindOfWeaponLabel.bottomAnchor, left: leftAnchor, paddingTop: 12,
										paddingLeft: 16)
		rightTypeOfWeaponStakView.anchor(top: whatKindOfWeaponLabel.bottomAnchor, left: leftTypeOfWeaponStakView.rightAnchor, paddingTop: 12, paddingLeft: 16)
		
		
	}
	
	public func setCategoryView(_ type: InjuriesInjuryTitle) {
		categoryView.setCategoryTitle(type.rawValue)
		self.injuriesInjuryType = type

	}

}


extension WeaponCausedTheInjuryView: CategoryInjuryAndXmarckViewDelegate {
	func closeAction() {
		delegate?.closeViewAction()
	}
	
}



extension WeaponCausedTheInjuryView: InjuriesInjuryViewDelegate {
	func didTapOnInjuriesView(_ view: InjuriesInjuryView) {
		guard let weaponType = view.getTypeWeapon() else { return }
		guard let injuriesInjuryType = injuriesInjuryType else { return }
		switch weaponType {
		case .smallArms:
			delegate?.presentVC(weapontype: weaponType, injuriesInjuryType: injuriesInjuryType)
		case .artillery:
			delegate?.presentVC(weapontype: weaponType, injuriesInjuryType: injuriesInjuryType)
		case .rocket:
			delegate?.presentVC(weapontype: weaponType, injuriesInjuryType: injuriesInjuryType)
		case .fpvDrone:
			delegate?.presentVC(weapontype: weaponType, injuriesInjuryType: injuriesInjuryType)
		case .tank:
			delegate?.presentVC(weapontype: weaponType, injuriesInjuryType: injuriesInjuryType)
		case .aviation:
			delegate?.presentVC(weapontype: weaponType, injuriesInjuryType: injuriesInjuryType)
		case .grenadeLauncher:
			delegate?.presentVC(weapontype: weaponType, injuriesInjuryType: injuriesInjuryType)
		case .mine:
			delegate?.presentVC(weapontype: weaponType, injuriesInjuryType: injuriesInjuryType)
		case .flamethrower:
			delegate?.presentVC(weapontype: weaponType, injuriesInjuryType: injuriesInjuryType)
		}
	}
}
