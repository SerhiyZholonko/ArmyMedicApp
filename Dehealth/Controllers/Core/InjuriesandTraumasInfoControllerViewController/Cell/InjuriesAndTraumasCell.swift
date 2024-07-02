//
//  InjuriesAndTraumasCell.swift
//  Dehealth
//
//  Created by apple on 23.02.2024.
//

import UIKit

protocol InjuriesAndTraumasCellDelegate: AnyObject {
	func openVCForAddInjuries()
}

class InjuriesAndTraumasCell: UICollectionViewCell {
    //MARK: - Properties
    weak var delegate: InjuriesAndTraumasCellDelegate?
    
    static let identifier = "InjuriesAndTraumasCell"
    private lazy var headerView: InjuriesAndTraumasCellHeader = {
        let view = InjuriesAndTraumasCellHeader()
        view.delegate = self
        return view
    }()
    private let manFrontImageView: UIImageView = {
        let image = UIImage(named: "manFront")
        let iv = UIImageView(image: image)
        iv.setWidth(154)
        iv.setHeight(280)
        return iv
    }()
    private let manBackImageView: UIImageView = {
        let image = UIImage(named: "manBack")
        let iv = UIImageView(image: image)
        iv.setWidth(154)
        iv.setHeight(280)
        return iv
    }()
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            manFrontImageView,
            manBackImageView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = -10
        return stackView
    }()
    private let spacerView: UIView = {
       let view = UIView()
        view.setWidth(20)
        return view
    }()
    private let colorView: AddColorView = {
        let view = AddColorView()
        return view
    }()
    private let previousActView: PreviousActView = {
      let view = PreviousActView()
        view.setHeight(32)
        return view
    }()
	 //MARK: -
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: -
	private func configureUI() {
		contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 16, paddingBottom: 8, paddingRight: 16)
		
		contentView.backgroundColor = .white
		addSubview(headerView)
		headerView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingRight: 16, height: 40)
//		addSubview(colorView)
//		colorView.anchor(left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingBottom: 10, height: 100)
		
		addSubview(imageStackView)
		imageStackView.anchor(top: headerView.bottomAnchor, left: contentView.leftAnchor, bottom: bottomAnchor, right: contentView.rightAnchor, paddingLeft: 28,  paddingBottom: 56,paddingRight: 28,  width: 326, height: 280)
		contentView.layer.cornerRadius = 12
        addSubview(previousActView)
        previousActView.anchor(top: imageStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
	}
	
}


 //MARK: - delegate
extension InjuriesAndTraumasCell: InjuriesAndTraumasCellHeaderDelegate {
	func openVCForAddInjuries() {
		delegate?.openVCForAddInjuries()
	}
}
#Preview() {
    InjuriesandTraumasInfoViewController()
}
