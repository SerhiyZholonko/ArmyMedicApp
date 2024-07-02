//
//  AxialIdentificationCell.swift
//  Dehealth
//
//  Created by apple on 14.02.2024.
//

import UIKit

protocol AxialIdentificationCellDelegate: AnyObject {
    func showDropBox()
}
class AxialIdentificationCell: UICollectionViewCell {
	 //MARK: - Properies
	static let identifier = "AxialIdentificationCell"
	
    weak var delegate: AxialIdentificationCellDelegate?
	private var axialIdentification: UILabel = {
		let label = UILabel()
		label.text = "Віськова ідентифікація"
		label.textColor = "#222222".hexColor()
		label.font = .interBold(size: 18)
		label.setHeight(24)
		return label
	}()
	private var callSignLabel: UILabel = {
		let label = UILabel()
		label.text = "Позивний"
		label.textColor = "#333333".hexColor()
		label.font = .interMedium(size: 14)
		label.setWidth(88)
		return label
	}()
	
	private var callSignTextField: UITextField =  {
		let tf = UITextField()
		tf.backgroundColor = "#FAFAFA".hexColor()
		tf.layer.cornerRadius = 6
		// Create left padding view
		let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.leftView = leftPaddingView
		tf.leftViewMode = .always

		// Create right padding view
		let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.rightView = rightPaddingView
		tf.rightViewMode = .always
		return tf
	}()
	private var rankLabel: UILabel = {
		let label = UILabel()
		label.setWidth(88)
		label.textColor = "#333333".hexColor()
		label.text = "Звання"
		label.font = .interMedium(size: 14)
		return label
	}()
	private lazy var rankView: DropdownSelectionView = {
		let view = DropdownSelectionView()
        view.delegate = self
		return view
	}()

	private var subdivisionLabel: UILabel = {
		let label = UILabel()
		label.setWidth(88)
		label.textColor = "#333333".hexColor()
		label.text = "Підрозділ"
		label.font = .interMedium(size: 14)
		return label
	}()
	private var subdivisionTextField: UITextField =  {
		let tf = UITextField()
		tf.backgroundColor = "#FAFAFA".hexColor()
		tf.layer.cornerRadius = 6

		// Create left padding view
		let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.leftView = leftPaddingView
		tf.leftViewMode = .always

		// Create right padding view
		let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.rightView = rightPaddingView
		tf.rightViewMode = .always
		return tf
	}()
	private var militaryUnitLabel = {
		let label = UILabel()
		label.text = "№ частини"
		label.textColor = "#333333".hexColor()
		label.font = .interMedium(size: 14)
		label.setWidth(88)
		label.numberOfLines = 2
		return label
	}()
	private var militaryUnitTextField:  UITextField =  {
		let tf = UITextField()
		tf.backgroundColor = "#FAFAFA".hexColor()
		tf.layer.cornerRadius = 6
		// Create left padding view
		let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.leftView = leftPaddingView
		tf.leftViewMode = .always

		// Create right padding view
		let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.rightView = rightPaddingView
		tf.rightViewMode = .always
		return tf
	}()
	 //MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: - Functions


	//MARK: - Functions
	private func configureUI() {
		// Add subviews
		backgroundColor = .white
		addSubviews()
		axialIdentification.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor,paddingTop: 20, paddingLeft: 16, paddingRight: 16)
		// Call Sign Label
		callSignLabel.anchor(top: axialIdentification.bottomAnchor, left: contentView.leftAnchor, paddingTop: 20, paddingLeft: 16)
		
		// Call Sign TextField
		callSignTextField.anchor(top: axialIdentification.bottomAnchor, left: callSignLabel.rightAnchor, right: contentView.rightAnchor, paddingTop: 20,
								 paddingLeft: 10, paddingRight: 16)
		callSignTextField.centerY(inView: callSignLabel)
		callSignTextField.setHeight(48)
		
		// Rank Label
		rankLabel.anchor(top: callSignTextField.bottomAnchor, left: contentView.leftAnchor, paddingTop: 8, paddingLeft: 16)
		
		// Rank View
		rankView.anchor(top: callSignTextField.bottomAnchor, left: rankLabel.rightAnchor, right: contentView.rightAnchor, paddingTop: 8,
						paddingLeft: 10, paddingRight: 16)
		rankView.centerY(inView: rankLabel)
		rankView.setHeight(48)
		
		// Subdivision Label
		subdivisionLabel.anchor(top: rankView.bottomAnchor, left: contentView.leftAnchor, paddingTop: 8, paddingLeft: 16)
		
		// Subdivision TextField (assuming it's a UITextField or similar)
		subdivisionTextField.anchor(top: rankView.bottomAnchor, left: subdivisionLabel.rightAnchor, right: contentView.rightAnchor, paddingTop: 8,
									paddingLeft: 10, paddingRight: 16)
		subdivisionTextField.centerY(inView: subdivisionLabel)
		subdivisionTextField.setHeight(48)
		
		// Military Unit Label
		militaryUnitLabel.anchor(top: subdivisionTextField.bottomAnchor, left: contentView.leftAnchor, paddingTop: 8, paddingLeft: 16)
		
		// Assuming there's a military unit text field or similar view
		militaryUnitTextField.anchor(top: subdivisionTextField.bottomAnchor,  left: militaryUnitLabel.rightAnchor, right: contentView.rightAnchor, paddingTop: 8,
									 paddingLeft: 10, paddingRight: 16)
		militaryUnitTextField.centerY(inView: militaryUnitLabel)
		militaryUnitTextField.setHeight(48)
//		militaryUnitTextField.anchor(bottom: contentView.bottomAnchor, paddingBottom: 20)
	}

	private func addSubviews() {
		contentView.addSubview(axialIdentification)
		contentView.addSubview(callSignLabel)
		contentView.addSubview(callSignTextField)
		contentView.addSubview(rankLabel)
		contentView.addSubview(rankView)
		contentView.addSubview(subdivisionLabel)
		contentView.addSubview(subdivisionTextField) // Add this assuming you have a similar text field for subdivisions
		contentView.addSubview(militaryUnitLabel)
		contentView.addSubview(militaryUnitTextField) // Add this assuming you have a similar text field for the military unit
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		configureUI()
	}

}


//MARK: - delegate

extension AxialIdentificationCell: DropdownSelectionViewDelegate {
    func noteShowDropBox() {
        
    }
    
    func bloodLoseShowDropBox() {
        
    }
    
  
    func bloodLosShowDropBox() {
        delegate?.showDropBox()

    }
    
    func devicesForBreathingShowDropBox() {
        
    }
    
}
#Preview() {
    MainInfoControllerViewController()
}
