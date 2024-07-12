//
//  ProgressBarFirstView.swift
//  Dehealth
//
//  Created by apple on 22.02.2024.
//

import UIKit

protocol ProgressBarFirstViewDelegate: AnyObject {
	func didTapBackButton()
}

class ProgressBarFirstView: UIView {
	 //MARK: - Properties
	weak var delegate: ProgressBarFirstViewDelegate?
    var tourniquets: [Tourniquet] = []
	private lazy var backButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(named: "CartArrow"), for: .normal)
		button.tintColor = .white
		button.addTarget(self, action: #selector(moveBack), for: .touchUpInside)
		return button
	}()
	private let titleLabel = CustomLabel(textLabel: "Створення картки", textColorLabel: ProgressBarFirstViewColor.titleColor.color , fontLabel: .interMedium(size: 20))
	 let oneView: NumberView = {
		let view = NumberView()
		view.setupBackgroundColor(color: .white)
//		view.setupNumber(number: .one)
		view.setWidth(36)
		view.setHeight(28)
		return view
	}()
	 let twoView: NumberView = {
		let view = NumberView()
		view.setupBackgroundColor(color: .blue)
//		view.setupNumber(number: .two)
		view.setupNumberColor(color: .white)
		view.setWidth(36)
		view.setHeight(28)
		return view
	}()
	 let threeView: NumberView = {
		let view = NumberView()
		view.setupBackgroundColor(color: .blue)
		view.setupNumber(number: .three)
		view.setupNumberColor(color: .white)
		view.setWidth(36)
		view.setHeight(28)
		return view
	}()

	private lazy var numberStackView: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [
		oneView, twoView, threeView
		])
		sv.setHeight(28)
		sv.distribution = .fillEqually
		sv.axis = .horizontal
		sv.spacing = 8
		return sv
	}()
	private let infoLabel = CustomLabel(textLabel: "Заповніть всі розділи", textColorLabel: .white, fontLabel: .interMedium(size: 14))
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
		backgroundColor = ProgressBarFirstViewColor.bgColor.color
		addSubview(backButton)
		backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16, width: 36, height: 32)
		addSubview(titleLabel)
		titleLabel.anchor(top: topAnchor, left: backButton.rightAnchor, paddingTop: 16, paddingLeft: 8, height: 32)
		addSubview(numberStackView)
		numberStackView.anchor( bottom: bottomAnchor, right: rightAnchor, paddingBottom: 12, paddingRight: 16, width: 124, height: 28)
		
		addSubview(infoLabel)
		infoLabel.setHeight(24)
		infoLabel.anchor( left: leftAnchor, bottom: bottomAnchor, paddingLeft: 16, paddingBottom: 18 )
		
	}
	func setupTitle(numberOfCart: String) {
		titleLabel.text = "Створення картки"
        //"Картка " + numberOfCart
	}
	@objc
	private func moveBack() {
		print(#function)
		delegate?.didTapBackButton()
	}
}

 //MARK: - color
enum ProgressBarFirstViewColor {
	case titleColor
	case bgColor
	
	var color: UIColor {
		switch self {
			
		case .titleColor:
			"#FFFFFF".hexColor()
		case .bgColor:
			"#5E42EC".hexColor()
		}
	}
}
