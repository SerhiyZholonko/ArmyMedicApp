//
//  PreviousActView.swift
//  Dehealth
//
//  Created by apple on 28.05.2024.
//

import UIKit


class PreviousActView: UIView {
     //MARK: - Properties
    private let plusImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "plus")
        iv.setWidth(24)
        iv.setHeight(24)
        return iv
    }()
    private let titleLabel = {
       let label = UILabel()
        label.text = "Попередній діагноз"
        label.font = .interMedium(size: 14)
        label.setWidth(200)
        return label
    }()
  
    
     //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    
    private func configureUI() {
       addSubview(plusImageView)
        addSubview(titleLabel)
        plusImageView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 115, paddingBottom: 20 )
        plusImageView.anchor(width: 24, height: 24)
        titleLabel.centerY(inView: plusImageView, leftAnchor: plusImageView.rightAnchor, paddingLeft: 5)
        
    }
    
}
