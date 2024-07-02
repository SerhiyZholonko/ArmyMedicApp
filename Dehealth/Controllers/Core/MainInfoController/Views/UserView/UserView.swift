//
//  UserView.swift
//  Dehealth
//
//  Created by apple on 01.03.2024.
//

import UIKit

protocol UserViewDelegate: AnyObject {
	func makeSynhronyze()
	func goToExit()
}

class UserView: UIView {
	 //MARK: - Properties
	weak var delegate: UserViewDelegate?
	private let contentView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		return view
	}()
	private let synchronizeView: ImageLabelView = {
		let image = UIImage(named: "upload")
		let view = ImageLabelView(image: image, text: "Синхронізувати дані")
		view.setHeight(24)
		view.setWidth(200)
		return view
	}()
	private let dividerView: UIView = {
		let view = UIView()
		view.backgroundColor = "#EBEDF5".hexColor()
		view.setHeight(1)
		return view
	}()
	private let signOutView: ImageLabelView = {
		let image = UIImage(named: "Exit")
		let view = ImageLabelView(image: image, text: "Вийти")
		view.setHeight(24)
		return view
	}()
	
	 //MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
		addGestures()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: - Functions
	private func configureUI() {
		backgroundColor = .clear
		addSubview(contentView)
		contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
		contentView.layer.cornerRadius = 12
		addSubview(dividerView)
		addSubview(synchronizeView)
		addSubview(signOutView)
		dividerView.centerY(inView: contentView)
		dividerView.anchor(left: contentView.leftAnchor, right: contentView.rightAnchor)
		synchronizeView.anchor( bottom: dividerView.topAnchor, paddingBottom: 16)
		synchronizeView.anchor(left: contentView.leftAnchor, paddingLeft: 20)
		signOutView.anchor(top: dividerView.bottomAnchor, paddingTop: 16)
		signOutView.anchor(left: contentView.leftAnchor, right: contentView.rightAnchor, paddingLeft: 20)
	}
	private func addGestures() {
		let exitTap = UITapGestureRecognizer(target: self, action: #selector(didTapExit))
		signOutView.addGestureRecognizer(exitTap)
	}
	@objc
	private func didTapExit() {
		delegate?.goToExit()
	}
	
}
