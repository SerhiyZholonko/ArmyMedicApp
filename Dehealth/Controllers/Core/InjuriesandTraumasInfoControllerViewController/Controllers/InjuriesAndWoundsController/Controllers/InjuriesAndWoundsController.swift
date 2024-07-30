//
//  InjuriesAndWoundsController.swift
//  Dehealth
//
//  Created by apple on 26.02.2024.
//

import UIKit

class InjuriesAndWoundsController: UIViewController {
	 //MARK: - Properties
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Травми та поранення"
		label.font = .interSemiBold(size: 20)
		label.setHeight(32)
		return label
	}()
	private lazy var dismissButton: UIButton = {
		let buttton = UIButton(type: .system)
		buttton.setImage(UIImage(named: "xmark2"), for: .normal)
		buttton.tintColor = .black
		buttton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
		return buttton
	}()
	private let frontImageView: UIImageView = {
		let image = UIImage(named: "manFront")
		let iv = UIImageView(image: image)
		return iv
	}()
	private let backImageView: UIImageView = {
		let image = UIImage(named: "manBack")
		let iv = UIImageView(image: image)
		return iv
	}()
	private let selectCategoryLabel: UILabel = {
		let label = UILabel()
		label.text = "Оберіть категорію щоб позначити на \nтілі пораненого:"
		label.font = .interSemiBold(size: 18)
		label.numberOfLines = 2
		return label
	}()
	private lazy var imageStackView: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [
			frontImageView, backImageView
		])
		sv.distribution = .fillProportionally
		sv.axis = .horizontal
		return sv
	}()
	private let injuriesLabel: UILabel = {
		let label = UILabel()
		label.text = "Поранення"
		label.font = .interMedium(size: 16)
		label.setHeight(24)
		return label
	}()
	private lazy var shrapnelWoundView: InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		//"Осколкове"
		view.setTitleInjuryLabel(.shrapnelDamage)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var shrapnelWound2View: InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleInjuryLabel(.bulletWound)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var shrapnelWound3View: InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleInjuryLabel(.contusionInjury)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var shrapnelWound4View: InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleInjuryLabel(.amputation)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var injuriesStackView: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [
			shrapnelWoundView,
			shrapnelWound2View,
			shrapnelWound3View,
			shrapnelWound4View
		])
		sv.distribution = .fillProportionally
		sv.spacing = 8
		sv.axis = .vertical
		return sv
	}()
	private let injuryTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Травма"
		label.textAlignment = .left
		label.font = .interMedium(size: 16)
		label.setHeight(24)
		return label
	}()
	private lazy var shrapnelWound5View: InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleInjuryLabel(.mechanical)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var shrapnelWound6View: InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleInjuryLabel(.burn)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private lazy var shrapnelWound7View: InjuriesInjuryView = {
		let view = InjuriesInjuryView()
		view.setTitleInjuryLabel(.poisoning)
		view.delegate = self
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	private let emptyView: UIView = {
		let view = UIView()
		view.backgroundColor = .clear
		view.setWidth(171)
		view.setHeight(32)
		return view
	}()
	
	private lazy var injuryStackView: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [
			shrapnelWound5View,
			shrapnelWound6View,
			shrapnelWound7View,
			emptyView
		])
		sv.distribution = .fillEqually
		sv.spacing = 8
		sv.axis = .vertical
		return sv
	}()
	private lazy var injuriesInjuryTaskStackView: UIStackView = {
		injuriesStackView.setWidth(171)
		injuryStackView.setWidth(171)
		let sv = UIStackView(arrangedSubviews: [
			injuriesStackView,
			injuryStackView
		])
		sv.axis = .horizontal
		sv.spacing = 12
		return sv
	}()
	private lazy var injuriesInjuryStacView: UIStackView = {
		injuriesLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
		injuriesLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)

		injuryTitleLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
		injuryTitleLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
		let stackView = UIStackView(arrangedSubviews: [
			injuriesLabel,
			injuryTitleLabel
		])
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		return stackView
	}()
	
	
	 //MARK: - init
	private lazy var detailCategoryView: WeaponCausedTheInjuryView = {
		let view = WeaponCausedTheInjuryView()
		view.delegate = self
		view.alpha = 0
		return view
	}()
	 //MARK: - Livecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}
	 //MARK: - Functions
	private func configureUI() {
		view.backgroundColor = .secondarySystemBackground
		view.addSubview(titleLabel)
		titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 17)
		view.addSubview(dismissButton)
		dismissButton.anchor( right: view.rightAnchor, paddingTop: 16, paddingRight: 17, width: 18, height: 18)
		dismissButton.centerY(inView: titleLabel)
		view.addSubview(imageStackView)
		imageStackView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, height: 280)
		view.addSubview(selectCategoryLabel)
		selectCategoryLabel.anchor(top: imageStackView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingBottom: 16)
		
		view.addSubview(injuriesInjuryStacView)
		injuriesInjuryStacView.anchor(top: selectCategoryLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 24, paddingLeft: 16, paddingRight: 16, height: 32)
		view.addSubview(injuriesInjuryTaskStackView)
		injuriesInjuryTaskStackView.anchor(top: injuriesInjuryStacView.bottomAnchor, left: view.leftAnchor, paddingTop: 12, paddingLeft: 16)
		
		view.addSubview(detailCategoryView)
		detailCategoryView.anchor(top: selectCategoryLabel.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
	}
	@objc
	private func dismissVC() {
		dismiss(animated: true)
	}
	
}

extension InjuriesAndWoundsController: InjuriesInjuryViewDelegate {
	func didTapOnInjuriesView(_ view: InjuriesInjuryView) {
		guard let type = view.getTypeInjury() else { return }
		switch type {
		case .shrapnelDamage:
			detailCategoryView.setCategoryView(type)
		case .bulletWound:
			detailCategoryView.setCategoryView(type)
		case .contusionInjury:
			detailCategoryView.setCategoryView(type)
		case .amputation:
			detailCategoryView.setCategoryView(type)
		case .mechanical:
			detailCategoryView.setCategoryView(type)
		case .burn:
			detailCategoryView.setCategoryView(type)
		case .poisoning:
			detailCategoryView.setCategoryView(type)
		}
		UIView.animate(withDuration: 0.3) { [weak self] in
			self?.detailCategoryView.alpha = 1
		}
	}
}



 //MARK: - delegate

extension InjuriesAndWoundsController: WeaponCausedTheInjuryViewDelegate {
	func presentVC(weapontype: WeaponCausedTheInjuryTitle, injuriesInjuryType: InjuriesInjuryTitle) {
//		let vc = SetWoundingController(viewModel: SetWoundingControllerViewModel(typeInjuries: injuriesInjuryType, typeWounding: weapontype))
//		vc.modalPresentationStyle = .fullScreen
//		vc.modalTransitionStyle = .crossDissolve
//		self.present(vc, animated: true)
	}
	
	
	func closeViewAction() {
		UIView.animate(withDuration: 0.3) { [weak self] in
			self?.detailCategoryView.alpha = 0
		}
	}
}


#Preview() {
    InjuriesAndWoundsController()
}
