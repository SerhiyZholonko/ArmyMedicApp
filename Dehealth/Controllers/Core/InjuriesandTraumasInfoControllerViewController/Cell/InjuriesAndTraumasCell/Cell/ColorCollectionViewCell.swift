//
//  ColorCollectionViewCell.swift
//  Dehealth
//
//  Created by apple on 02.07.2024.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
     //MARK: - Properties
    static let identifier = "ColorCollectionViewCell"
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
        backgroundColor = .blue
    }
}
