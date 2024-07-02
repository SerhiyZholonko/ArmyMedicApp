//
//  TourniquetCell.swift
//  Dehealth
//
//  Created by apple on 23.02.2024.
//

import UIKit

class TourniquetCell: UICollectionViewCell {
	 //MARK: - Properties
//	let buttonBourderColor = "#8B92AC".hexColor()
	let buttonTitleColor = "#333333".hexColor()
	let titleLabelColor = "#222222".hexColor()
	private lazy var titleLabel = CustomLabel(textLabel: "Турнікет", textColorLabel: titleLabelColor, fontLabel: .interMedium(size: 18))
	private lazy var addButton = CustomButton( image: UIImage(named: "plus"), customFont: .interMedium(size: 14))
	static let identifier = "TourniquetCell"
	 //MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
        configureButton()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: - Functions
    private func configureButton() {
        addButton.setWidth(24)
        addButton.setHeight(24)
        addButton.imageEdgeInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
    }
	private func configureUI() {
		contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
		contentView.backgroundColor = .white
		contentView.layer.cornerRadius = 12
		titleLabel.setHeight(24)
		addButton.setHeight(24)
		addSubview(titleLabel)
		titleLabel.anchor( left: contentView.leftAnchor, paddingLeft: 16)
		titleLabel.centerY(inView: contentView)
		addSubview(addButton)
		addButton.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 12, paddingBottom: 12, paddingRight: 16, width: 85)
	}
	func setTitle(title: String) {
		titleLabel.text = title
	}
}
#Preview() {
    InjuriesandTraumasInfoViewController()
}
