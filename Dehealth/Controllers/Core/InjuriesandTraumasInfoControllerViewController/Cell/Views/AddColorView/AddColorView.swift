//
//  AddColorView.swift
//  Dehealth
//
//  Created by apple on 23.02.2024.
//


import UIKit

class AddColorView: UIView {

	// MARK: - Properties
	private let scrollView = UIScrollView()
	private let stackView = UIStackView()

	// MARK: - Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupScrollView()
		setupStackView()
		addButtonsToStackView()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupScrollView()
		setupStackView()
		addButtonsToStackView()
	}

	// MARK: - Setup ScrollView
	private func setupScrollView() {
		addSubview(scrollView)
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: self.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		])
	}

	// MARK: - Setup StackView
	private func setupStackView() {
		scrollView.addSubview(stackView)
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.spacing = 10
		stackView.alignment = .center

		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
			stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			stackView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
		])
	}

	// MARK: - Add Buttons to StackView
	private func addButtonsToStackView() {
		// Sample button titles
		let titles = ["Осколкове", "Кульове", "Контужія", "Ампутація", "Механічна", "Опік", "Отруєння"]
		let colors: [UIColor] = [.red, .brown, .blue, .black, .darkGray, .orange, .green]
		
		for (index, title) in titles.enumerated() {
			let button = UIButton(type: .system)
			button.setTitle(title, for: .normal)
			button.backgroundColor = colors[index % colors.count]
			button.setTitleColor(.white, for: .normal)
			button.layer.cornerRadius = 10
			button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

			stackView.addArrangedSubview(button)
		}
	}
}
