//
//  AlertSaveChange.swift
//  Dehealth
//
//  Created by apple on 21.05.2024.
//

import UIKit


protocol AlertSaveChangeDelegate: AnyObject {
    func exitButtonDidTap()
    func saveButtonDidTap()
}

//TODO: - Alert if result doesn't save


class AlertSaveChange: UIViewController {
     //MARK: - Properties
    weak var delegate: AlertSaveChangeDelegate?
    private let saveImageView: UIImageView = {
       let iv = UIImageView(image: UIImage(named: "image 12"))
        iv.setWidth(57.1)
        iv.setHeight(56)
        
        return iv
    }()
    private let titleAlertLabel: UILabel = {
       let label = UILabel()
        label.text = "Зберегти зміни ?"
        label.font = .interSemiBold(size: 20)
        label.setHeight(32)
        return label
    }()
    private let messageLabel: UILabel = {
       let label = UILabel()
        label.font = .interLight(size: 16)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Ви внесли зміни і намагаєтесь вийти без збереження"
        
        return label
    }()
    
    private let exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Вийти", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        let bourderColor = "#8B92AC".hexColor().cgColor
        button.layer.borderColor = bourderColor
        button.setWidth(98)
        button.setHeight(48)
        button.tintColor = .black
        button.titleLabel?.font = .interMedium(size: 16)
        return button
    }()
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зберегти і вийти", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        let bourderColor = "#8B92AC".hexColor().cgColor
        button.layer.borderColor = bourderColor
        button.setWidth(194)
        button.setHeight(48)
        button.tintColor = .white
        button.titleLabel?.font = .interMedium(size: 16)
        let bgColor = "#5E42EC".hexColor()
        button.backgroundColor = bgColor
        return button
    }()
    private let SaveAndExitButton: UIButton = {
       let button = UIButton()
        button.setTitle("Зберегти і вийти", for: .normal)
        return button
    }()
    private lazy var bgView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.setWidth(358)
        view.setHeight(292)
        return view
    }()
     //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupFunctionsForButtons()
    }
     //MARK: - Functions
    private func configureUI() {
        view.backgroundColor = .black
        view.addSubview(bgView)
        bgView.center(inView: view)
        view.addSubview(saveImageView)
        saveImageView.centerX(inView: view, topAnchor: bgView.topAnchor, paddingTop: 24)
        view.addSubview(titleAlertLabel)
        titleAlertLabel.centerX(inView: view, topAnchor: saveImageView.bottomAnchor, paddingTop: 16)
        view.addSubview(messageLabel)
        messageLabel.anchor(top: titleAlertLabel.bottomAnchor, left: bgView.leftAnchor, right: bgView.rightAnchor, paddingTop: 12, paddingLeft: 24, paddingRight: 24, height: 48)
        
        view.addSubview(exitButton)
        exitButton.anchor(left: bgView.leftAnchor, bottom: bgView.bottomAnchor, paddingLeft: 24, paddingBottom: 24 )
        
        view.addSubview(saveButton)
        saveButton.anchor( bottom: bgView.bottomAnchor, right: bgView.rightAnchor, paddingBottom: 24, paddingRight: 24, width: 194, height: 48)
        
    }
    private func setupFunctionsForButtons() {
        exitButton.addTarget(self, action: #selector(exitDidTap), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveDidTap), for: .touchUpInside)
    }
    @objc
    private func exitDidTap() {
        delegate?.exitButtonDidTap()
    }
    @objc
    private func saveDidTap() {
        delegate?.saveButtonDidTap()
    }
    
}


#Preview() {
    AlertSaveChange()
}
