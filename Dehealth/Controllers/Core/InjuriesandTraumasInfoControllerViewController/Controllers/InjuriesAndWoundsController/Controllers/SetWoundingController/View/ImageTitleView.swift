//
//  ImageTitleView.swift
//  Dehealth
//
//  Created by apple on 22.07.2024.
//

import UIKit

class ImageTitleView: UIView {
    //MARK: - Properties
    private let customImageView: UIImageView = {
        let defaultImage = UIImage(named: "mine:IED")
        let iv = UIImageView(image: defaultImage)
        return iv
    }()
    private let customTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Міна/СВП"
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
    func setTitle(_ model: InjuriesAndTraumasModel) {
        customImageView.image = UIImage(named: model.imageName)
        customTitleLabel.text = model.title
    }
    private func configureUI() {
        addSubview(customImageView)
        customImageView.centerY(inView: self, leftAnchor: leftAnchor)
        customImageView.anchor( width: 20, height: 20)
        addSubview(customTitleLabel)
        customTitleLabel.anchor(top: topAnchor, left: customImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10)
    }
    
}
