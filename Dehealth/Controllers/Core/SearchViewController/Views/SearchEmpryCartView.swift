//
//  SearchEmpryCartView.swift
//  Dehealth
//
//  Created by apple on 06.02.2024.
//

import UIKit


class SearchEmpryCartView: UIView {
	 //MARK: - Properties
	private let emptyImageview: UIImageView = {
		let image = UIImage(named: "ne results")
		let iv = UIImageView(image: image)
        iv.setWidth(24)
        iv.setHeight(24)
		return iv
	}()
	private let textLabel: UILabel = {
		let label = UILabel()
		label.text = "За цим ID нічого не знайдено"
        label.font = .interMedium(size: 16)
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
addSubview(emptyImageview)
        emptyImageview.centerX(inView: self, topAnchor: topAnchor, paddingTop: 0)
        addSubview(textLabel)
        textLabel.centerX(inView: self, topAnchor: emptyImageview.bottomAnchor, paddingTop: 12)
        
	}
}
