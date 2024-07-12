//
//  PhotoCell.swift
//  Dehealth
//
//  Created by apple on 04.07.2024.
//

import UIKit
protocol PhotoCellDelegate: AnyObject {
    func addButtonDidTap()
}
class PhotoCell: UICollectionViewCell {
     //MARK: - Properties
    static let identifier = "PhotoCell"
    weak var delegate: PhotoCellDelegate?
    let buttonTitleColor = "#333333".hexColor()
    let titleLabelColor = "#222222".hexColor()
    private lazy var titleLabel = CustomLabel(textLabel: "Фото", textColorLabel: titleLabelColor, fontLabel: .interMedium(size: 18))
    private lazy var addButton: UIButton = {
        let button = UIButton()
        let image =  UIImage(named: "plus")
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        return button
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
    func setTitle(title: String) {
        titleLabel.text = title
    }
    private func configureUI() {
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        titleLabel.setHeight(24)
        addButton.setHeight(24)
        addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 12, paddingLeft: 16)
        addSubview(addButton)
        addButton.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, paddingTop: 12,  paddingRight: 16, width: 24, height: 24)
    }
    @objc
    private func addButtonDidTap() {
        delegate?.addButtonDidTap()
        print("addButtonDidTap")
    }
}
