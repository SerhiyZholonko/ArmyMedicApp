//
//  EmptyCartView.swift
//  Dehealth
//
//  Created by apple on 06.02.2024.
//

import UIKit


class EmptyCartView: UIView {

	 //MARK: - Properties
	private let contentView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.layer.cornerRadius = 8
		return view
	}()
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 2
		label.text = "Тут відображатимуться останні заповнені та переглянуті картки поранених бійців"
		label.font = .interLight(size: 14)
		label.textAlignment = .center
		return label
	}()
	 //MARK: - Livecycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: - Functions
	private func configureUI() {
		backgroundColor = .clear
		addSubview(contentView)
		contentView.addSubview(titleLabel)
		contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
		titleLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 24, paddingLeft: 20, paddingBottom: 24, paddingRight: 20)

	}

}
