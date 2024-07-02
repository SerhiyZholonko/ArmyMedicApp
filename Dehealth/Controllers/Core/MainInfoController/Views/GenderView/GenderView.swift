//
//  GenderView.swift
//  Dehealth
//
//  Created by apple on 17.05.2024.
//
import UIKit

enum Gender {
    case man
    case woman
}

protocol GenderViewDelegate: AnyObject {
    func setGender(_ gender: Gender)
}

class GenderView: UIView {
    weak var delegate: GenderViewDelegate?
    private var isPadding10 = false
    private let genderTitle: UILabel = {
       let label = UILabel()
        label.text = "Стать"
        label.font = .interLight(size: 14)
        label.setHeight(24)
        label.setWidth(80)
        return label
    }()
    private var manRadioButton: UIButton = {
       let button = UIButton()
        button.setWidth(24)
        button.setHeight(24)
        return button
    }()
    private let manLabel: UILabel = {
        let label = UILabel()
        label.text = "чоловіча"
        label.font = .interLight(size: 16)
        label.setWidth(69)
        label.setHeight(24)
        return label
    }()
    private var womanRadioButton: UIButton = {
       let button = UIButton()
        button.setWidth(24)
        button.setHeight(24)
        return button
    }()
    private let womanLabel: UILabel = {
        let label = UILabel()
        label.text = "жінча"
        label.setWidth(69)
        label.setHeight(24)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        prepareButton()
        backgroundColor = .systemBackground
        addSubview(genderTitle)
        genderTitle.centerY(inView: self, leftAnchor: leftAnchor)
        addSubview(manRadioButton)
        manRadioButton.centerY(inView: self,  leftAnchor: genderTitle.rightAnchor, paddingLeft: 8)
        addSubview(manLabel)
        manLabel.centerY(inView: self, leftAnchor: manRadioButton.rightAnchor, paddingLeft: 8)
        addSubview(womanRadioButton)
        womanRadioButton.centerY(inView: self, leftAnchor: manLabel.rightAnchor, paddingLeft: isPadding10 ? 20 : 10)
        addSubview(womanLabel)
        womanLabel.centerY(inView: self, leftAnchor: womanRadioButton.rightAnchor, paddingLeft: 8)
    }
    
    private func prepareButton() {
        manRadioButton = createRadioButton(imageName: "NoPickPoint", frame: .zero)
        womanRadioButton = createRadioButton(imageName: "NoPickPoint", frame: .zero)
        manRadioButton.isSelected = true
    }
    func setPadding10(_ bool: Bool ) {
        isPadding10 = bool
    }
    func setTitles(titlePosition: String, titleSitting: String, titleLyingDown: String) {
        manRadioButton.isSelected = false
        genderTitle.text = titlePosition
        manLabel.text = titleSitting
        womanLabel.text = titleLyingDown
    }
    func createRadioButton(imageName: String, frame: CGRect) -> UIButton {
        let radioButton = UIButton()
        radioButton.frame = frame
        radioButton.setImage(UIImage(named: imageName), for: .normal)
        radioButton.setImage(UIImage(named: "PickPoint"), for: .selected)
        radioButton.imageView?.tintColor = .black
        radioButton.tintColor = nil
        radioButton.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        return radioButton
    }
    
    @objc func radioButtonTapped(_ sender: UIButton) {
        if sender == self.manRadioButton {
            delegate?.setGender(.man)
        } else {
            delegate?.setGender(.woman)

        }
        UIView.animate(withDuration: 0.3) {
           
            self.manRadioButton.isSelected = (sender == self.manRadioButton)
            self.womanRadioButton.isSelected = (sender == self.womanRadioButton)
        }
    }
}
