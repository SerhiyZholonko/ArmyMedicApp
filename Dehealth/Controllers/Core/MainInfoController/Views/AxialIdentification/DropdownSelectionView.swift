//
//  DropdownSelectionView.swift
//  Dehealth
//
//  Created by apple on 15.02.2024.
//

import UIKit

protocol DropdownSelectionViewDelegate: AnyObject {
    func bloodLoseShowDropBox()
    func devicesForBreathingShowDropBox()
    func noteShowDropBox()
}

class DropdownSelectionView: UIView {
    weak var delegate: DropdownSelectionViewDelegate?
    private let label = UILabel()
    private let dropdownImage: UIImageView = {
        let iv = UIImageView()
        let dropdownImage = UIImage(named: "trinagle 1")
        iv.image = dropdownImage
        iv.tintColor = .black
        return iv
    }()
    
    enum Action {
        case bloodLose
        case devicesForBreathing
        case note
    }
    
    var currentAction: Action = .bloodLose // Default action

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitle(_ title: String) {
        let words = title.split(separator: ", ").map { String($0) }
        let uniqueWords = Array(Set(words)).joined(separator: ", ")
        label.text = uniqueWords
    }
    
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        self.addGestureRecognizer(tap)
    }
    
    private func setupView() {
        backgroundColor = "#FAFAFA".hexColor()
        label.text = ""
        label.textColor = .black700
        label.textAlignment = .left
        label.font = .interMedium(size: 16)
        label.setHeight(24)
        
        addSubview(label)
        addSubview(dropdownImage)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        dropdownImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            label.trailingAnchor.constraint(equalTo: dropdownImage.leadingAnchor, constant: -12),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            dropdownImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
            dropdownImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            dropdownImage.widthAnchor.constraint(equalToConstant: 10),
            dropdownImage.heightAnchor.constraint(equalToConstant: 5)
        ])
        
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = "#EBEDF5".hexColor().cgColor
    }
    
    @objc
    private func didTap() {
        
        switch currentAction {
        case .bloodLose:
            delegate?.bloodLoseShowDropBox()
        case .devicesForBreathing:
            delegate?.devicesForBreathingShowDropBox()
        case .note:
            delegate?.noteShowDropBox()
        }
    }
}


