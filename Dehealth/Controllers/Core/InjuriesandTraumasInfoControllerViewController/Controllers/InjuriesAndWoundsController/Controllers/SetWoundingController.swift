//
//  SetWoundingController.swift
//  Dehealth
//
//  Created by apple on 28.02.2024.
//

import UIKit

class SetWoundingController: UIViewController {
	 //MARK: - Properties
	private let viewModel: SetWoundingControllerViewModelPro
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Торкніться пальцем щоб \nпозначити"
		label.numberOfLines = 2
		label.font = .interSemiBold(size: 20)
		return label
	}()
	private lazy var dismissButton: UIButton = {
		let buttton = UIButton(type: .system)
		buttton.setImage(UIImage(named: "xmark2"), for: .normal)
		buttton.tintColor = .black
		buttton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
		return buttton
	}()
	private lazy var woundingColorView: WoundingColorView = {
		let view = WoundingColorView()
		view.setSetPaaneter(viewModel.typeInjuries)
		return view
	}()
	private lazy var weaponDropBoxView : WeaponDropBoxView = {
		let view = WeaponDropBoxView()
		view.setTitleWeaponLabel(viewModel.typeWounding)
		return view
	}()
	 //MARK: - Livecycle
	init(viewModel: SetWoundingControllerViewModelPro) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		print("viewModel.typeWounding.rawValu: ", viewModel.typeWounding.rawValue)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}
	 //MARK: - Functions
	private func configureUI() {
		view.backgroundColor = .secondarySystemBackground
		view.addSubview(dismissButton)
		view.addSubview(titleLabel)
		view.addSubview(woundingColorView)
		view.addSubview(weaponDropBoxView)
		dismissButton.anchor( right: view.rightAnchor, paddingRight: 17, width: 18, height: 18)
		dismissButton.centerY(inView: titleLabel)
		titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
		woundingColorView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 24, paddingLeft: 16, width: 197, height: 32)
		weaponDropBoxView.anchor( left: woundingColorView.rightAnchor, paddingLeft: 12, height: 32)
		weaponDropBoxView.centerY(inView: woundingColorView)
	}
	@objc
	private func dismissVC() {
		dismiss(animated: true)
	}
}
