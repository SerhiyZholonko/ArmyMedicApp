//
//  NumberView.swift
//  Dehealth
//
//  Created by apple on 22.02.2024.
//

import UIKit

enum NumberViewColor {
	case blue
	case white
	case bourderColor
	case clear
	var color: UIColor {
		switch self {
		case .blue:
			return "#3925B0".hexColor()
		case .white:
			return "#FFFFFF".hexColor()
		case .bourderColor:
			return "#9270F2".hexColor()
		case .clear:
			return .clear
		}
	}
}
enum numberViewNumber {
	case one
	case two
	case three
	case four
	case `nil`
	var number: String {
		switch self {
			
		case .one:
			"1"
		case .two:
			"2"
		case .three:
			"3"
		case .four:
			"4"
		case .nil:
			""
		}
	}
}
class NumberView: UIView {
	 //MARK: -
	private let numberLabel = CustomLabel(textLabel: "", textColorLabel: "#333333".hexColor(), fontLabel: .interLight(size: 14), alignmentLabel: .center)
	private let chakImage: UIImageView = {
		let image = UIImage(named: "whiteCheckmark")
		let iv = UIImageView(image: image)
		return iv
	}()
	 //MARK: -
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	 //MARK: -
	private func configureUI() {
		addSubview(numberLabel)
		
		numberLabel.center(inView: self)
		self.setWidth(36)
		self.setHeight(28)
		self.layer.cornerRadius = 8
	}
	func setupBackgroundColor(color: NumberViewColor) {
		backgroundColor = color.color
	}
	func setupNumberColor(color: UIColor) {
		numberLabel.textColor = color
	}
	func setupNumber(number: numberViewNumber) {
		if number == .nil {
			setupImage()
			backgroundColor = .clear
//			layer.borderColor = "#9270F2".hexColor().cgColor
//			layer.borderWidth = 1
		} else {
			numberLabel.text = number.number
		}
	}
	func setupImage() {
		addSubview(chakImage)
		chakImage.center(inView: self)
		chakImage.setWidth(10)
		chakImage.setHeight(8)
	}
	
}
