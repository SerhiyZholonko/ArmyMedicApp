//
//  WoundingColorView.swift
//  Dehealth
//
//  Created by apple on 28.02.2024.
//

import UIKit

class WoundingColorView: UILabel {
	 //MARK: - Properties
	
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
		layer.cornerRadius = 8
		clipsToBounds = true
		textAlignment = .center
		textColor = .white
		font = .interMedium(size: 16)
	}
	
	public func setSetPaaneter(_ type: InjuriesInjuryTitle) {
		backgroundColor = type.color
		text = type.rawValue
	}
}
