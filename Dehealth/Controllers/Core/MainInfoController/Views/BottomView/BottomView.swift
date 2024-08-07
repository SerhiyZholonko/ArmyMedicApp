//
//  BottomView.swift
//  Dehealth
//
//  Created by apple on 22.02.2024.
//
//
import UIKit

protocol BottomViewDelegate: AnyObject {
	func moveToNextSection()
	func moveToBackSection()
}
class BottomView: UIView {
	 //MARK: - Properties
	weak var delegate: BottomViewDelegate?
	private let backButton = CustomButton( title: "Назад", tintColor: BackButtonColor.textColor.value, borderColor: BackButtonColor.bourderColor.value, customFont: .interBlack(size: 16))
	private lazy var nextButton: CustomButton = {
		let button = CustomButton( title: "Настуний розділ", tintColor: NextButtonColor.textColor.value, customFont: .interBold(size: 16))
		button.setHeight(48)
		button.backgroundColor = NextButtonColor.bgColor.value
		button.layer.borderWidth = 0
		button.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
		return  button
	}()
	 //MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
		configureButtons()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: - Functions
    func setIsEnableRightButton(_ bool: Bool) {
        //TODO: - 
//        nextButton.isEnabled = bool
        if bool {
            nextButton.backgroundColor = .purple400
        } else {
            nextButton.backgroundColor = .purple600
        }
    }
    func setTitleForRightButton(_ title: String) {
        backButton.setTitle(title, for: .normal)
    }
    func setTitleForLeftButton(_ title: String) {
        nextButton.setTitle(title, for: .normal)
    }
	private func configureButtons() {
		backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
	}
	private func configureUI() {
		backgroundColor = BottomViewColor.bgColor.value
		backButton.backgroundColor = BackButtonColor.bgColor.value
		addSubview(nextButton)
		addSubview(backButton)
		nextButton.anchor( right: rightAnchor, paddingRight: 16, width: 236, height: 48)
		nextButton.centerY(inView: self)
		backButton.anchor(left: leftAnchor, right: nextButton.leftAnchor, paddingLeft: 16, paddingRight: 24, height: 48)
		backButton.centerY(inView: self)
	}
	@objc
	private func backButtonDidTap() {
		delegate?.moveToBackSection()
	}
	@objc
	private func nextButtonDidTap() {
		delegate?.moveToNextSection()
	}
}

enum BackButtonColor {
	case textColor
	case bourderColor
	case bgColor
	var value: UIColor {
		switch self {
		case .textColor:
			"#A0A0A0".hexColor()
		case .bourderColor:
			"#EBEDF5".hexColor()
		case .bgColor:
			"#FAFAFA".hexColor()
		}
	}
}
enum NextButtonColor {
	case textColor
	case bgColor
	
	var value: UIColor {
		switch self {
		case .textColor:
			"#FFFFFF".hexColor()
		case .bgColor:
			"#5E42EC".hexColor()
		}
	}
}

enum BottomViewColor {
	case bgColor
	var value: UIColor {
		switch self {
			
		case .bgColor:
			"#F4F4F7".hexColor()
		}
	}
}

