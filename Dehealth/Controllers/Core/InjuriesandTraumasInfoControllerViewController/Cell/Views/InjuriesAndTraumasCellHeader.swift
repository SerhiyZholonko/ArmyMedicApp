//
//  InjuriesAndTraumasCellHeader.swift
//  Dehealth
//
//  Created by apple on 23.02.2024.
//

import UIKit

protocol InjuriesAndTraumasCellHeaderDelegate: AnyObject {
	func openVCForAddInjuries()
    func showInjuryList()
}

class InjuriesAndTraumasCellHeader: UIView {
	 //MARK: - Properties
	weak var delegate: InjuriesAndTraumasCellHeaderDelegate?
    var isInjuries: Bool = false
    var  isInjuryListView: Bool = false {
        didSet {
            updateRotateTriangleInButton()
        }
    }
	let buttonBorderColor = "#8B92AC".hexColor()
   
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Механізм поранення"
		label.font = .interMedium(size: 18)
		label.setHeight(24)
		return label
	}()
	private lazy var infoLabel: UILabel = {
		let label = UILabel()
        label.text = isInjuries ? "Обов’язково вказати" : ""
		label.font = .interLight(size: 14)
		label.setHeight(24)
		label.textColor = .red
		return label
	}()
	private lazy var titleStackView: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [
			titleLabel,
			infoLabel
		])
		sv.axis = .vertical
		return sv
	}()
    private let markLabel: UILabel = {
       let label = UILabel()
        label.text = "Позначити"
        label.font = .interMedium(size: 12)
        return label
    }()
    private let markImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "triangle")
        return iv
    }()
	private lazy var markButton: UIButton = {
		let button = UIButton(type: .system)
        button.tintColor = .black
		button.layer.borderColor = self.buttonBorderColor.cgColor
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 8
		return button
	}()

	 //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureButtons()

    }
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: - Functions
    private func updateRotateTriangleInButton() {
        markImageView.transform =  isInjuryListView ? CGAffineTransform(rotationAngle: .pi) : CGAffineTransform(rotationAngle: .zero)
    }
    private func configureButtons() {
		markButton.addTarget(self, action: #selector(markTheInjury), for: .touchUpInside)
	}
	private func configureUI() {
		addSubview(titleStackView)
		addSubview(markButton)
		
		markButton.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 6, paddingBottom: 6, width: 113, height: 32)
        addSubview(markLabel)
        markLabel.centerY(inView: markButton, leftAnchor: markButton.leftAnchor, paddingLeft: 12)
        addSubview(markImageView)
        markImageView.centerY(inView: markLabel, leftAnchor: markLabel.rightAnchor, paddingLeft: 11)
        markImageView.anchor(width: 10, height: 5)
		
		titleStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: markButton.leftAnchor, paddingTop: 6, paddingBottom: 6, paddingRight: 16 )
	}
	@objc
	private func markTheInjury() {
        isInjuryListView.toggle()
        delegate?.showInjuryList()
	}
}




