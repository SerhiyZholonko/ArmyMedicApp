//
//  SearchCell.swift
//  Dehealth
//
//  Created by apple on 16.02.2024.
//

import UIKit
import Kingfisher

class SearchCell: UICollectionViewCell {
	 //MARK: - Properties
	static let identifier = "SearchCell"
	
	private let photoImageView: UIImageView = {
		let image = UIImage(named: "Soldat")
		let iv = UIImageView(image: image)
		return iv
	}()
	private let numberLabel: UILabel = {
		let label = UILabel()
		label.text = "203 36 14"
		return label
	}()
	private let arrowImageView: UIImageView = {
		let image = UIImage(named: "SearchArrow")
		let iv = UIImageView(image: image)
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
		backgroundColor = .clear
		contentView.backgroundColor = .white
		addSubViews()
		contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,  paddingLeft: 16, paddingRight: 16)
		photoImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, width: 56)
		
		arrowImageView.anchor( right: contentView.rightAnchor, paddingRight: 18, width: 20, height: 20)
		arrowImageView.centerY(inView: self)
		numberLabel.anchor( left: photoImageView.rightAnchor, right: arrowImageView.leftAnchor, paddingLeft: 8, paddingRight: 8, height: 24)
		numberLabel.centerY(inView: self)
         contentView.layer.cornerRadius = 8
	}
	private func addSubViews() {
		addSubview(photoImageView)
		addSubview(arrowImageView)
		addSubview(numberLabel)
		
	}
    func configureCell(viewModel: SingleDefenderModel) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.numberLabel.text = viewModel.identifier
            self.photoImageView.kf.setImage(with: URL(string: viewModel.photoURL), placeholder: UIImage(named: "Soldat"))
            
            // Create a UIBezierPath to define the clipping area (left side)
            let maskPath = UIBezierPath(roundedRect: self.photoImageView.bounds,
                                        byRoundingCorners: [.topLeft, .bottomLeft],
                                        cornerRadii: CGSize(width: 8, height: 8))
            
            // Create a CAShapeLayer to use as the mask layer
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.photoImageView.bounds
            maskLayer.path = maskPath.cgPath
            
            // Apply the mask layer to the image view's layer
            self.photoImageView.layer.mask = maskLayer
        }
    }
}
