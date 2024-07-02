//
//  ImageLabelView.swift
//  Dehealth
//
//  Created by apple on 01.03.2024.
//
import UIKit

class ImageLabelView: UIView {
	
	let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	let label: UILabel = {
		let label = UILabel()
		label.textAlignment = .left
		label.textColor = .black // Ensure text color is visible
		label.font = .interLight(size: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	init(image: UIImage?, text: String) {
		super.init(frame: .zero)
		backgroundColor = .white // Set a contrasting background color for debugging
		
		addSubview(imageView)
		addSubview(label)
		
		imageView.image = image
		label.text = text
		
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
			imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			imageView.widthAnchor.constraint(equalToConstant: 20), // Set your desired width
			imageView.heightAnchor.constraint(equalToConstant: 20), // Set your desired height
			
			label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
			label.trailingAnchor.constraint(equalTo: trailingAnchor),
			label.topAnchor.constraint(equalTo: topAnchor),
			label.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

