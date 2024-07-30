//
//  EditView.swift
//  Dehealth
//
//  Created by apple on 18.07.2024.
//

import UIKit

protocol EditViewDelegate: AnyObject {
    func editDidTapped()
}

class EditView: UIView {
     //MARK: - Properties
    weak var delegate: EditViewDelegate?
    private let editLabel: UILabel = {
       let label = UILabel()
        label.text = "Редагування"
        label.font = .interLight(size: 14)
        label.setHeight(24)
        return label
    }()
    private let dividerView: UIView = {
       let view = UIView()
        view.backgroundColor = .black200
        return view
    }()
    private let conversionLabel: UILabel = {
       let label = UILabel()
        label.text = "Конверсія"
        label.font = .interLight(size: 14)
        label.setHeight(24)
        return label
    }()
     //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addGesture()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    private func configureUI() {
        backgroundColor = .white
        layer.cornerRadius = 12
        addSubview(dividerView)
        dividerView.centerY(inView: self, leftAnchor: leftAnchor, rightAnchor: rightAnchor)
        dividerView.anchor(height: 1)
        addSubview(editLabel)
        editLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 20)
        addSubview(conversionLabel)
        conversionLabel.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 20, paddingBottom: 10)
    }
    private func addGesture() {
        editLabel.isUserInteractionEnabled = true
        let editTap = UITapGestureRecognizer(target: self, action: #selector(editDidTapped))
        editLabel.addGestureRecognizer(editTap)
        
        conversionLabel.isUserInteractionEnabled = true
        let conversionTap = UITapGestureRecognizer(target: self, action: #selector(conversionDidTapped))
        conversionLabel.addGestureRecognizer(conversionTap)
    }
    @objc
    private func conversionDidTapped() {
        print("TapTap")
    }
    @objc
    private func editDidTapped() {
        print("Tap")
    }
    
}
