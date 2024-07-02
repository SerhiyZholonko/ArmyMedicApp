//
//  SearchByIdView.swift
//  Dehealth
//
//  Created by apple on 06.02.2024.
//

import UIKit

protocol SearchByIdViewDelegate: AnyObject {
	func searchDidTouch()
}

class SearchByIdView: UIView {
	//MARK: - Properties
	weak var delegate: SearchByIdViewDelegate?
    private let titleLabel = CustomLabel(textLabel: "Пошук картки по ID", textColorLabel: .black, fontLabel: .interBold(size: CGFloat(TextStyle.Heading3.sizes.first!)), alignmentLabel: .center)

	private let searchLabel: UILabel = {
		let label = UILabel()
		label.text = "Введіть ID пораненого"
		label.font = UIFont.interLight(size: 14)
		label.textColor = "#808080".hexColor()
		label.backgroundColor = .clear
		label.textAlignment = .left
		return label
	}()

	private let searchImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage(named: "search"))
		imageView.contentMode = .scaleAspectFit
		imageView.tintColor = "#808080".hexColor()
		imageView.setWidth(20)
		imageView.setHeight(20)
		return imageView
	}()

	private lazy var searchStackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [searchImageView, searchLabel])
		stackView.axis = .horizontal
		stackView.spacing = 8
		stackView.backgroundColor = .white
		stackView.alignment = .center
		stackView.layer.cornerRadius = 6

		// Add tap gesture recognizer
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchStackViewTapped))
		stackView.addGestureRecognizer(tapGesture)

		return stackView
	}()
//
	private let qrButton: UIButton = {
		let button = UIButton(type: .system)
		button.tintColor = .white
		let image = UIImage(named: "QRcode")
		button.setImage(image, for: .normal)
        button.backgroundColor = .purple600
		button.setWidth(56)
		button.setHeight(48)
		button.layer.cornerRadius = 8
		return button
	}()



	// Container view for searchStackView with left and right padding
	private lazy var searchContainerView: UIView = {
		let view = UIView()
		view.addSubview(searchStackView)
		view.backgroundColor = .white
		view.layer.cornerRadius = 8
		searchStackView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 12)
		return view
	}()



	//MARK: - Livecycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	//MARK: - Functions
	private func configureUI() {
		backgroundColor = "#DEE1F3".hexColor()
		layer.cornerRadius = 16
		// Add title label
		addSubview(titleLabel)
		titleLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)


	
		addSubview(qrButton)
        qrButton.anchor(top: titleLabel.bottomAnchor, right: rightAnchor, paddingTop: 24, paddingRight: 20,  width: 56, height: 48)
        addSubview(searchContainerView)
        searchContainerView.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, right: qrButton.leftAnchor, paddingTop: 24, paddingLeft: 20, paddingRight: 16, height: 48)
		searchContainerView.addSubview(searchStackView)
		searchStackView.centerY(inView: searchContainerView)
		searchContainerView.anchor( left: searchContainerView.leftAnchor, right: searchContainerView.rightAnchor, paddingLeft: 0, paddingRight: 0)



	}

	//MARK: - Gesture Recognizer
	@objc private func searchStackViewTapped() {
		// Handle tap on search stack view
		delegate?.searchDidTouch()
		print("Search stack view tapped")
	}
}





