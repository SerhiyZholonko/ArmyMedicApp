//
//  File.swift
//  Dehealth
//
//  Created by apple on 16.02.2024.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
	let titleLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		// Customize your header view here
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(titleLabel)
		titleLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
		titleLabel.centerY(inView: self)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
