//
//  EvacuationCell.swift
//  Dehealth
//
//  Created by apple on 15.02.2024.
//

import UIKit


class EvacuationCell: UICollectionViewCell {
	 //MARK: - Properties
	static let identifier = "EvacuationCell"
	
	private let evacuationTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Евакуація"
		label.font = .interBold(size: 18)
		return label
	}()
	private let priorityLabel: UILabel = {
		let label = UILabel()
		label.text = "Пріорітет"
		label.font = .interMedium(size: 14)
		label.textColor = "#333333".hexColor()
		return label
	}()
	private lazy var prioritySegmentedControl: UISegmentedControl = {
		  let sc = UISegmentedControl(items: ["Терміновий", "Високий", "Звичайний"])
		  sc.selectedSegmentIndex = 0
		  sc.backgroundColor = .white
		  sc.tintColor = .blue // This will not affect the text color or background on iOS 13+
		  // On iOS 13+, use the following to customize the appearance
		sc.selectedSegmentTintColor = "#5E42EC".hexColor()
		  let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		  sc.setTitleTextAttributes(titleTextAttributes, for: .selected)
		  let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
		  sc.setTitleTextAttributes(normalTextAttributes, for: .normal)
		sc.setHeight(48)
		// Configure text font size
		let font = UIFont.interMedium(size: 16) // Change the size as needed
		let selectedAttributes: [NSAttributedString.Key: Any] = [
			.font: font,
			.foregroundColor: UIColor.white
		]
		let normalAttributes: [NSAttributedString.Key: Any] = [
			.font: font,
			.foregroundColor: UIColor.black
		]
		
		sc.setTitleTextAttributes(normalAttributes, for: .normal)
		sc.setTitleTextAttributes(selectedAttributes, for: .selected)

		  sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
		  return sc
	  }()
	private let provisionsLabel: UILabel = {
		let label = UILabel()
		label.text = "Положення"
		label.font = .interMedium(size: 14)
		label.textColor = "#333333".hexColor()
		return label
	}()
	private lazy var provisionsSegmentedControl: UISegmentedControl = {
		  let sc = UISegmentedControl(items: ["Сидячи", "Звичайний"])
		  sc.selectedSegmentIndex = 0
		  sc.backgroundColor = .white
		  sc.tintColor = .blue // This will not affect the text color or background on iOS 13+
		  // On iOS 13+, use the following to customize the appearance
		sc.selectedSegmentTintColor = "#5E42EC".hexColor()
		  let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		  sc.setTitleTextAttributes(titleTextAttributes, for: .selected)
		  let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
		  sc.setTitleTextAttributes(normalTextAttributes, for: .normal)
		sc.setHeight(48)
		// Configure text font size
		let font = UIFont.interMedium(size: 16) // Change the size as needed
		let selectedAttributes: [NSAttributedString.Key: Any] = [
			.font: font,
			.foregroundColor: UIColor.white
		]
		let normalAttributes: [NSAttributedString.Key: Any] = [
			.font: font,
			.foregroundColor: UIColor.black
		]
		
		sc.setTitleTextAttributes(normalAttributes, for: .normal)
		sc.setTitleTextAttributes(selectedAttributes, for: .selected)

		  sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
		  return sc
	  }()
	private let transportationLabel: UILabel = {
		let label = UILabel()
		label.text = "Транспорт"
		label.font = .interMedium(size: 14)
		label.textColor = "#333333".hexColor()
		return label
	}()
	private lazy var transportationSegmentedControl: UISegmentedControl = {
		  let sc = UISegmentedControl(items: ["Наземний", "Повітряний", "Звичайний"])
		  sc.selectedSegmentIndex = 0
		  sc.backgroundColor = .white
		  sc.tintColor = .blue // This will not affect the text color or background on iOS 13+
		  // On iOS 13+, use the following to customize the appearance
		sc.selectedSegmentTintColor = "#5E42EC".hexColor()
		  let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
		  sc.setTitleTextAttributes(titleTextAttributes, for: .selected)
		  let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
		  sc.setTitleTextAttributes(normalTextAttributes, for: .normal)
		sc.setHeight(48)
		// Configure text font size
		let font = UIFont.interMedium(size: 16) // Change the size as needed
		let selectedAttributes: [NSAttributedString.Key: Any] = [
			.font: font,
			.foregroundColor: UIColor.white
		]
		let normalAttributes: [NSAttributedString.Key: Any] = [
			.font: font,
			.foregroundColor: UIColor.black
		]
		
		sc.setTitleTextAttributes(normalAttributes, for: .normal)
		sc.setTitleTextAttributes(selectedAttributes, for: .selected)

		  sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
		  return sc
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
		backgroundColor = .white
		addSubViews()
		evacuationTitleLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 24)
		priorityLabel.anchor(top: evacuationTitleLabel.bottomAnchor, left: evacuationTitleLabel.leftAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 16, height: 48)
		prioritySegmentedControl.anchor(top: priorityLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
		provisionsLabel.anchor(top: prioritySegmentedControl.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, height: 48)
		provisionsSegmentedControl.anchor(top: provisionsLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, height: 48)
		provisionsSegmentedControl.widthAnchor.constraint(equalTo: prioritySegmentedControl.widthAnchor, multiplier: 0.66).isActive = true
		transportationLabel.anchor(top: provisionsSegmentedControl.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, height: 24)
		transportationSegmentedControl.anchor(top: transportationLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16, height: 48)
	}
	private func addSubViews() {
		addSubview(evacuationTitleLabel)
		addSubview(priorityLabel)
		addSubview(prioritySegmentedControl)
		addSubview(provisionsLabel)
		addSubview(provisionsSegmentedControl)
		addSubview(transportationLabel)
		addSubview(transportationSegmentedControl)
		
	}
	
	@objc 
	func segmentChanged(_ sender: UISegmentedControl) {
		   // Handle the segment change
		   print("Selected segment index: \(sender.selectedSegmentIndex)")
	   }
}
#Preview() {
    MainInfoControllerViewController()
}
