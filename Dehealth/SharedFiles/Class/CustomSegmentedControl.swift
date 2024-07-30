//
//  CustomSegmentedControl.swift
//  Dehealth
//
//  Created by apple on 12.07.2024.
//

import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func segmentControlDidChange(_tag: Int)
}

final class CustomSegmentedControl: UIView {
    weak var delegate: CustomSegmentedControlDelegate?

    private let stackView = UIStackView()
    private let selectedView = UIView()
    private var widthConstraint = NSLayoutConstraint ()
    private var leadingConstraint = NSLayoutConstraint()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureStackView()
        configureSelectedView()
        setConstraints()
    }
    
    convenience init(_ buttonText: String...) {
        self.init()
        buttonText.enumerated().forEach {
            let button: UIButton = UIButton.createSegmentedButton(title: $0.element)
            button.tag = $0.offset
            button.titleLabel?.textColor = .black
            button.tintColor = .black
            button.titleLabel?.font = .interMedium(size: 12)
            button.addTarget(self, action: #selector(segmentedButtonTapped) , for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        DispatchQueue.main.async {
            self.widthConstraint.constant = self.stackView.arrangedSubviews[0].frame.width
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc
    private func segmentedButtonTapped (sender: UIButton) {
        widthConstraint.constant = stackView.arrangedSubviews[sender.tag].frame.width
        leadingConstraint.constant = stackView.arrangedSubviews[sender.tag].frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
        delegate?.segmentControlDidChange(_tag: sender.tag)
    }
}





private extension CustomSegmentedControl {
    func configure() {
    layer.cornerRadius = 10
    layer.borderColor = UIColor.black200!.cgColor
    layer.borderWidth = 1
    backgroundColor = .clear
    translatesAutoresizingMaskIntoConstraints = false
}
    func configureStackView() {
        stackView.layer.cornerRadius = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
    }

        func configureSelectedView() {
            
            selectedView.backgroundColor = UIColor.black200!
            
            selectedView.layer.cornerRadius = 8
            
            selectedView.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.addSubview(selectedView)
        }
        func setConstraints () {
            widthConstraint = selectedView.widthAnchor.constraint(equalToConstant: 0)
            leadingConstraint = selectedView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor)
            widthConstraint.isActive = true
            leadingConstraint.isActive = true
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topAnchor, constant: 4), stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4), stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4), stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
                selectedView.topAnchor.constraint(equalTo: stackView.topAnchor),selectedView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            ])
        }
}

