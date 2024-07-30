//
//  HeaderInjuriesAndTraumasListDetailView.swift
//  Dehealth
//
//  Created by apple on 25.07.2024.
//

import UIKit


protocol HeaderInjuriesAndTraumasListDetailViewDelegate: AnyObject {
    func backButtonDidTap()
}

class HeaderInjuriesAndTraumasListDetailView: UIView {
     //MARK: - Properties
    weak var delegate: HeaderInjuriesAndTraumasListDetailViewDelegate?
    private lazy var backButton: UIButton = {
           let button = UIButton(type: .system)
           var config = UIButton.Configuration.plain()
           config.image = UIImage(named: "backButton")
           config.title = "Нвзад"
           config.imagePadding = 12
           button.configuration = config
           button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
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
    
    private func configureUI() {
        addSubview(backButton)
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12)
    }
    @objc
    private func backButtonDidTap() {
        delegate?.backButtonDidTap()
    }
    
}
