//
//  HeadeMainView.swift
//  Dehealth
//
//  Created by apple on 05.02.2024.
//

import UIKit

protocol HeaderMainViewDelegate: AnyObject {
	func getUserInfo()
}

class HeaderMainView: UIView {
	//MARK: - Properties
	weak var delegate: HeaderMainViewDelegate?
	private let logoImageView: UIImageView = {
		let image = UIImage(named: "logo")
		let iv = UIImageView(image: image)
		iv.setWidth(40)
		iv.setHeight(40)
		return iv
	}()
	private let userImageView: UIImageView = {
		let image = UIImage(named: "button-icon")
		let iv = UIImageView(image: image)
		iv.setWidth(40)
		iv.setHeight(40)
		iv.isUserInteractionEnabled = true
		return iv
	}()
	private let synchronizeLabel: UILabel = {
		let label = UILabel()
		label.text = "Синхронізовано"
		label.textColor = .black
		label.font = .interMedium(size: 14)
		label.textAlignment = .center
		return label
	}()
	private let synchronizeImageView: UIImageView = {
		let image = UIImage(named: "iconSingronize")
		let iv = UIImageView(image: image)
		iv.setWidth(18)
		iv.setHeight(18)
		return iv
	}()
	private let internetLabel: UILabel = {
		let label = UILabel()
		label.text = "Є інтернет"
		label.textColor = .systemGreen
		label.font = .interMedium(size: 14)
		label.textAlignment = .center
		return label
	}()
	private lazy var synchronizeStackView: UIStackView = {
let sv = UIStackView(arrangedSubviews: [synchronizeImageView, synchronizeLabel])
		sv.axis = .horizontal
		sv.distribution = .equalCentering
		sv.spacing = 3
		return sv
	}()
	private lazy var synchronizeInternetStackView: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [synchronizeStackView, internetLabel])
		sv.axis = .vertical
		sv.distribution = .equalCentering
		sv.spacing = 0
		return sv
	}()
	//MARK: - Livecycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
		addGesture()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Functions
	private func configureUI() {
		backgroundColor = .white
		addSubview(logoImageView)
		logoImageView.centerY(inView: self, leftAnchor: self.leftAnchor, paddingLeft: 16)
		addSubview(userImageView)
		userImageView.centerY(inView: self, rightAnchor: self.rightAnchor, paddingRight: 16)
		addSubview(synchronizeInternetStackView)
		synchronizeInternetStackView.center(inView: self)
	}
	private func addGesture() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(getUserInfo))
		userImageView.addGestureRecognizer(tap)
	}

	@objc
	private func getUserInfo() {
		delegate?.getUserInfo()
	}

}
