//
//  VerticalPikerView.swift
//  Dehealth
//
//  Created by apple on 08.07.2024.
//

import UIKit

enum PikerStage {
    case pikedOne
    case pikedTwo
}

protocol VerticalPikerViewDelegate: AnyObject {
    func setTypeForMethod(_ point: PikerStage)
}

class VerticalPikerView: UIView {
    // MARK: - Properties
    weak var delegate: VerticalPikerViewDelegate?

    private lazy var firstRadioButton: UIButton = {
//        let button = createRadioButton()
        let button = UIButton()
        button.setImage(UIImage(named: "NoPickPoint"), for: .normal)
        button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        button.setWidth(24)
        button.setHeight(24)
        return button
    }()

    private let firstTitle: UILabel = {
        let label = UILabel()
        label.text = "Швидкий"
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()

    private lazy var secondRadioButton: UIButton = {
//        let button = createRadioButton()
        let button = UIButton()
        let image = UIImage(named: "PickPoint")
        button.setImage(image, for: .selected)
        button.setWidth(24)
        button.setHeight(24)
        button.addTarget(self, action: #selector(radioButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private let secondTitle: UILabel = {
        let label = UILabel()
        label.text = "Прицільний"
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    private func configureUI() {
        addSubview(firstRadioButton)
        firstRadioButton.anchor(top: topAnchor, left: leftAnchor)

        addSubview(firstTitle)
        firstTitle.centerY(inView: firstRadioButton, leftAnchor: firstRadioButton.rightAnchor, paddingLeft: 8)

        addSubview(secondRadioButton)
        secondRadioButton.anchor(top: firstRadioButton.bottomAnchor, left: leftAnchor, paddingTop: 8)

        addSubview(secondTitle)
        secondTitle.centerY(inView: secondRadioButton, leftAnchor: secondRadioButton.rightAnchor, paddingLeft: 8)

        firstRadioButton.isSelected = true
        updateRadioButtonImages()
    }

    private func createRadioButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "NoPickPoint"), for: .normal)
        button.setImage(UIImage(named: "PickPoint"), for: .selected)
        button.setWidth(24)
        button.setHeight(24)
        return button
    }

    private func updateRadioButtonImages() {
        firstRadioButton.setImage(UIImage(named: firstRadioButton.isSelected ? "PickPoint" : "NoPickPoint"), for: .normal)
        secondRadioButton.setImage(UIImage(named: secondRadioButton.isSelected ? "PickPoint" : "NoPickPoint"), for: .normal)
    }

    @objc private func radioButtonTapped(_ sender: UIButton) {
        if sender == firstRadioButton {
            delegate?.setTypeForMethod(.pikedOne)
            firstRadioButton.isSelected = true
            secondRadioButton.isSelected = false
        } else if sender == secondRadioButton {
            delegate?.setTypeForMethod(.pikedTwo)
            firstRadioButton.isSelected = false
            secondRadioButton.isSelected = true
        }

        UIView.animate(withDuration: 0.3) {
            self.updateRadioButtonImages()
        }
    }
    func selectDefaultButton(_ stage: PikerStage) {
          switch stage {
          case .pikedOne:
              firstRadioButton.isSelected = true
              secondRadioButton.isSelected = false
          case .pikedTwo:
              firstRadioButton.isSelected = false
              secondRadioButton.isSelected = true
          }

          updateRadioButtonImages()
      }
}

