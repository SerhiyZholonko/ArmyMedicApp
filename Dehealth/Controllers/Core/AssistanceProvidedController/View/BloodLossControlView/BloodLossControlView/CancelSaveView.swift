//
//  CancelSaveView.swift
//  Dehealth
//
//  Created by apple on 18.06.2024.
//

import UIKit

protocol CancelSaveViewDelegate: AnyObject {
    func moveToNextSection()
    func moveToBackSection()
}
class CancelSaveView: UIView {
     //MARK: - Properties
    weak var delegate: CancelSaveViewDelegate?
//    private let backButton = CustomButton( title: "Назад", tintColor: BackButtonColor.textColor.value, borderColor: BackButtonColor.bourderColor.value, customFont: .interBlack(size: 16))
     lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Назад", for: .normal)
        button.tintColor = .black500
        button.layer.borderColor = UIColor.black200?.cgColor
         button.layer.cornerRadius = 8
         button.layer.borderWidth = 1
        button.isEnabled = false
        button.titleLabel?.font = .interBlack(size: 16)
        return button
    }()
    private lazy var nextButton: CustomButton = {
        let button = CustomButton( title: "Настуний розділ", tintColor: NextButtonColor.textColor.value, customFont: .interBold(size: 16))
        button.setHeight(48)
        button.backgroundColor = NextButtonColor.bgColor.value
        button.layer.borderWidth = 0
        button.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        return  button
    }()
    private lazy var buttonsStackView: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [backButton, nextButton])
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.spacing = 16
        return sv
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
    func setIsEnableLeftButton(_ bool: Bool) {
        nextButton.isEnabled = bool
        if bool {
            nextButton.backgroundColor = .purple400
        } else {
            nextButton.backgroundColor = .purple600
        }
    }
    func setIsEnableRightButton(_ bool: Bool) {
        backButton.isEnabled = bool
        if bool {
            backButton.tintColor = BackButtonColor.textColor.value
            backButton.layer.borderColor = BackButtonColor.bourderColor.value.cgColor
            
        } else {
            backButton.tintColor = .black700
            backButton.layer.borderColor = UIColor.black400?.cgColor
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
        addSubview(buttonsStackView)
        buttonsStackView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    @objc
    private func backButtonDidTap() {
        print("backButtonDidTap")
        
        delegate?.moveToBackSection()
    }
    @objc
    private func nextButtonDidTap() {
        delegate?.moveToNextSection()
    }
}

#Preview() {
    AssistanceProvidedController()
}
