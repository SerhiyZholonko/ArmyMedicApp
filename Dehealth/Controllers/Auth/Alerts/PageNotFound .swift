//
//  PageNotFound .swift
//  Dehealth
//
//  Created by apple on 05.02.2024.
//

import UIKit


class PageNotFound: UIViewController {
	//MARK: - Properties
	weak var deleagte: AlertDelegate?
	private let imageNoInternet: UIImageView = {
		let iv = UIImageView(image: UIImage(named: "404-error 1"))
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.setWidth(104)
		iv.setHeight(104)
		iv.heightAnchor.constraint(equalToConstant: 104).isActive = true
		return iv
	}()
	private lazy var imageNoInternetStackView: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [UIView(), imageNoInternet, UIView()])
		sv.axis = .horizontal
		sv.distribution = .fillEqually
		return sv
	}()
	private let titleLabel: UILabel = {
		let label = UILabel()

		label.text = "Сторінку не знайдено"
		label.font = .interBold(size: 24)
		label.textAlignment = .center
		label.numberOfLines = 2
		return label
	}()
	private lazy var updateButton: TestCustomLoginButton = {
		let button = TestCustomLoginButton()
		button.setTitle("Повернутись на головну", for: .normal)
		button.titleLabel?.font = .interMedium(size: 16.0)
		button.backgroundColor = "#5E42EC".hexColor()
		button.layer.cornerRadius = 8
		button.setHeight(48)
		button.setWidth(244)
		button.addTarget(self, action: #selector(updateButtonDidTap), for: .touchUpInside)
		return button
	}()
	private lazy var updateButtonStackView: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [UIView(), updateButton, UIView()])
		sv.axis = .horizontal
		sv.distribution = .fillProportionally
		return sv
	}()
	private lazy var contentStack: UIStackView = {
		let sv = UIStackView(arrangedSubviews: [imageNoInternetStackView, titleLabel])
		sv.axis = .vertical
		sv.distribution = .equalCentering
		sv.spacing = 24
		return sv
	}()
	//MARK: - Livecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}


	//MARK: - Functions
	private func configureUI() {
		view.backgroundColor = .white
		view.addSubview(contentStack)
		contentStack.center(inView: view, yConstant: -72)
		view.addSubview(updateButton)
		updateButton.anchor(top: contentStack.bottomAnchor, paddingTop: 24, width: 244, height: 48)
		updateButton.centerX(inView: view)
	}
	@objc
	private func updateButtonDidTap() {
			deleagte?.dismissAlert()
			dismiss(animated: true)
	}
}
