//
//  TwoButtonView.swift
//  Dehealth
//
//  Created by apple on 24.07.2024.
//

import UIKit

protocol TwoButtonViewDelegate: AnyObject {
    func backButtonDidTap()
}

class TwoButtonView: UIView {
     //MARK: - Properties
    weak var delegate: TwoButtonViewDelegate?
    private lazy var backButton:UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "arrow-go-back-left")
        button.setImage(image, for: .normal)
        button.tintColor = .black400
        button.layer.borderColor = UIColor.black200!.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        return button
    }()
    private let nextButton:UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "arrow-go-back-right")
        button.setImage(image, for: .normal)
        button.tintColor = .black400
        button.layer.borderColor = UIColor.black200!.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 6
        return button
    }()
     //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    func backButtonIsActive(isActive: Bool) {
        if isActive {
            backButton.tintColor = .black700
        } else {
            backButton.tintColor = .black400
        }
    }
    private func configureUI() {
        addSubview(backButton)
        backButton.centerY(inView: self, leftAnchor: leftAnchor)
        backButton.anchor(width: 40, height: 32)
        addSubview(nextButton)
        nextButton.centerY(inView: backButton, leftAnchor: backButton.rightAnchor)
        nextButton.anchor( width: 40, height: 32)
    }
    @objc
    private func backButtonDidTap() {
        delegate?.backButtonDidTap()
    }
}
