//
//  SignsAndSymptomsCollectionViewCell.swift
//  Dehealth
//
//  Created by apple on 05.06.2024.
//

import UIKit

class SignsAndSymptomsCollectionViewCell: UICollectionViewCell {
     //MARK: - Properties
    static let identifier = "SignsAndSymptomsCollectionViewCell"
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Частота дихання"
        label.font = .interMedium(size: 16)
        label.setHeight(24)
        label.tintColor = .black700
        return label
    }()
    private let subTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "р/хв"
        label.font = .interMedium(size: 10)
        label.setHeight(12)
        label.textColor = .black400
        return label
    }()
     //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    
    private func configureCell() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor)
        addSubview(subTitleLabel)
        subTitleLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor)
    }
    
}
