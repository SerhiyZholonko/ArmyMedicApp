//
//  PointTextView.swift
//  Dehealth
//
//  Created by apple on 14.02.2024.
//

import UIKit

protocol PointTextViewDelegate: AnyObject {
	func markDidTap()
    func markImageButtonDidSelected()
}

class PointTextView: UIView {
	//MARK: - Properties
	weak var delegate: PointTextViewDelegate?
	 lazy var markImageButton: ImagePickerButton = {
         let button = ImagePickerButton(frame: .zero)
        button.delegate = self
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	private let sexLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 16) // Adjust the font as needed
        label.text = "Woman"
		return label
	}()
	
	// Gesture recognizer
	private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
		return gestureRecognizer
	}()
	
	//MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
		addGestureRecognizer(tapGestureRecognizer) // Add gesture recognizer
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Function
	func configureCell(title: String) {
		sexLabel.text = title
	}
	private func configureUI() {
		// Add markImageButton
		addSubview(markImageButton)
        markImageButton.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, width: 30, height: 24)
		markImageButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			markImageButton.centerYAnchor.constraint(equalTo: centerYAnchor),
			markImageButton.leadingAnchor.constraint(equalTo: leadingAnchor),
			markImageButton.widthAnchor.constraint(equalToConstant: 24), // Adjust the width as needed
			markImageButton.heightAnchor.constraint(equalToConstant: 24) // Adjust the height as needed
		])
		
//		 Add sexLabel
		addSubview(sexLabel)
        sexLabel.anchor(top: topAnchor, left: markImageButton.rightAnchor, bottom: bottomAnchor, right: rightAnchor)
		sexLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			sexLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			sexLabel.leadingAnchor.constraint(equalTo: markImageButton.trailingAnchor, constant: 8),
			sexLabel.heightAnchor.constraint(equalToConstant: 20) // Adjust the height as needed
		])
	}

	@objc
    private func handleMarkImageButtonTapped() {
		// Handle tap on markImageButton
		print("Mark image button tapped!")
		delegate?.markDidTap()
	}
	
	// Handle tap gesture
	@objc
    private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
		// Handle tap gesture on the view
		print("PointTextView tapped!")
		// You can add any additional handling logic here if needed
	}
}





extension PointTextView: ImagePickerButtonDelegate {
    func didSelected() {
        delegate?.markImageButtonDidSelected()
    }
    
    
}

#Preview(traits: .fixedLayout(width: 120, height: 40)) {
    PointTextView()
}
