//
//  TypeOfTrainingViewCell.swift
//  Dehealth
//
//  Created by apple on 09.07.2024.
//

import UIKit

class TypeOfTrainingViewCell: UITableViewCell{
     //MARK: - Properties
    static let identifier = "TypeOfTrainingViewCell"
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Title"
        return label
    }()
     //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    private func configureUI() {
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        addSubview(titleLabel)
        titleLabel.centerY(inView: contentView, leftAnchor: contentView.leftAnchor, paddingLeft: 20)
        
    }
}
