//
//  BigSpecifyTheExactLocationView.swift
//  Dehealth
//
//  Created by apple on 11.07.2024.
//

import UIKit

class BigSpecifyTheExactLocationView: UIView {
    //MARK: - Properties
   //Tourniquet
   private let titleLabel: UILabel = {
      let label = UILabel()
       label.text = "Вкажіть точне розташування *"
       label.font = .interLight(size: 14)
       return label
   }()
   private let tourniquetImageView: UIImageView = {
       let image = UIImage(named: "Tourniquet2")
      let iv = UIImageView(image: image)
       iv.contentMode = .scaleAspectFit
       return iv
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
       backgroundColor = .white
       addSubview(titleLabel)
       titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingLeft: 20, height: 24)
       addSubview(tourniquetImageView)
       tourniquetImageView.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 20, paddingRight: 20)
   }
}
