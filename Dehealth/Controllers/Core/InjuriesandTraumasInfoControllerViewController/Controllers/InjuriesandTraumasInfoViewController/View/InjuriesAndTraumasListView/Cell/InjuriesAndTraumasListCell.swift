//
//  InjuriesAndTraumasListCell.swift
//  Dehealth
//
//  Created by apple on 22.07.2024.
//

import UIKit

class InjuriesAndTraumasListCell: UICollectionViewCell {
     //MARK: - Properties
    static let identifier: String = "InjuriesAndTraumasListCell"
    private let injuriesAndTraumasImageView: UIImageView = {
        let image = UIImage(named: "fragmentary")
      let iv = UIImageView(image: image)
        return iv
    }()
    private let injuriesAndTraumasLabel: UILabel = {
        let label = UILabel()
        label.font = .interMedium(size: 14)
        label.text = "Уламковий"
        return label
    }()
    private let nextArrowImageView: UIImageView = {
        let image = UIImage(named: "nextArrow")
        let iv = UIImageView(image: image)
        iv.alpha = 0
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
    //MARK: - Properties
    func configureCell(_ model: InjuriesAndTraumasModel) {
        injuriesAndTraumasImageView.image = UIImage(named: model.imageName)
        injuriesAndTraumasLabel.text = model.title
        if model.typeOfTransition == .withSection {
            nextArrowImageView.alpha = 1
        }
    }
    private func configureUI() {
        backgroundColor = .white
        addSubview(injuriesAndTraumasImageView)
        injuriesAndTraumasImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 16)
        injuriesAndTraumasImageView.anchor(width: 20, height: 20)
        addSubview(injuriesAndTraumasLabel)
        injuriesAndTraumasLabel.centerY(inView: self, leftAnchor: injuriesAndTraumasImageView.rightAnchor, paddingLeft: 12)
        injuriesAndTraumasLabel.anchor( height: 24)
        addSubview(nextArrowImageView)
        nextArrowImageView.anchor(width: 18, height: 18)
        nextArrowImageView.centerY(inView: self, rightAnchor: rightAnchor, paddingRight: 15)
    }
    
}
