//
//  CancelAddButtonsView.swift
//  Dehealth
//
//  Created by apple on 12.06.2024.
//

import UIKit

protocol CancelAddButtonsViewDelegate: AnyObject {
    func cancelButtonDidTap()
    func addButtonDidTap()
}

class CancelAddButtonsView: UIView {
     //MARK: - Properties
    weak var delegate: CancelAddButtonsViewDelegate?
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Відміна", for: .normal)
        button.titleLabel?.font = .interSemiBold(size: 16)
        button.tintColor = .black700
        button.layer.borderColor = UIColor.black400?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.setWidth(108)
        button.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
        return button
    }()
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Додати", for: .normal)
        button.titleLabel?.font = .interSemiBold(size: 16)
        button.tintColor = .white
        button.backgroundColor = .purple600
//        button.layer.borderColor = UIColor.black.cgColor
//        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.setWidth(108)
        button.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        return button
    }()
    private lazy var buttonsStackView: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [
        cancelButton, addButton
       ])
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.spacing = 16
        return sv
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
        addSubview(buttonsStackView)
        buttonsStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    @objc
    private func cancelButtonDidTap() {
        delegate?.cancelButtonDidTap()
    }
    @objc
    private func addButtonDidTap() {
        delegate?.addButtonDidTap()
    }
}
#Preview() {
    AssistanceProvidedController()
}
