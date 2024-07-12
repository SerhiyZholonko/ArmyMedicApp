//
//  DeleteAddButtonView.swift
//  Dehealth
//
//  Created by apple on 01.07.2024.
//

import UIKit
protocol DeleteAddButtonViewDelegate: AnyObject {
    func addButtonDidTap()
    func deleteButtonDidTap()
}
class DeleteAddButtonView: UIView {
     //MARK: - Properties
    weak var delegate: DeleteAddButtonViewDelegate?
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Додати", for: .normal)
        button.backgroundColor = .purple600
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .interMedium(size: 14)
        button.tintColor = .white
        return button
    }()
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Видалити", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.red300, for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.red300!.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = .interMedium(size: 14)
        return button
    }()

    private lazy var buttonsStack: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [
        deleteButton,
        addButton
       ])
        sv.axis = .horizontal
        sv.spacing = 16
        sv.distribution = .fillProportionally
        return sv
    }()
     //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupFunctionsForButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    private func configureUI() {
        addSubview(buttonsStack)
        buttonsStack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    private func setupFunctionsForButton() {
        addButton.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonDidTap), for: .touchUpInside)
    }
    @objc
    private func addButtonDidTap() {
        delegate?.addButtonDidTap()
    }
    @objc
    private func deleteButtonDidTap() {
        delegate?.deleteButtonDidTap()
    }
}
