//
//  PlaceOfCombatOperations.swift
//  Dehealth
//
//  Created by apple on 15.02.2024.
//

import UIKit


class PlaceOfCombatOperationsCell: UICollectionViewCell {
	//MARK: - Properties
	static let identifier = "PlaceOfCombatOperations"
	private var placeOfCombatLabel: UILabel = {
		let label = UILabel()
		label.text = "Місце бойових дій"
		label.textColor = "#222222".hexColor()
		label.font = .interBold(size: 18)
		label.setHeight(24)
		return label
	}()

	
	private var numberOperationTextField: UITextField =  {
		let tf = UITextField()
		tf.backgroundColor = "#FAFAFA".hexColor()
		tf.layer.cornerRadius = 6
		let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.leftView = leftPaddingView
		tf.leftViewMode = .always
		let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.rightView = rightPaddingView
		tf.rightViewMode = .always
		return tf
	}()
	private var timeDateLabel: UILabel = {
		let label = UILabel()
		label.text = "Дата і час"
		label.textColor = "#333333".hexColor()
		label.font = .interMedium(size: 14)
		label.setWidth(88)
		return label
	}()
	private lazy var timeTextField: UITextField =  {
		let tf = UITextField()
		tf.backgroundColor = "#FAFAFA".hexColor()
		tf.layer.cornerRadius = 6
        tf.placeholder = "_ _ : _ _"
        tf.keyboardType = .numberPad
		// Create left padding view
		let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.leftView = leftPaddingView
		tf.leftViewMode = .always
        tf.addTarget(self, action: #selector(textChangedTime(_:)), for: .editingChanged)

		// Create right padding view
		let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.rightView = rightPaddingView
		tf.rightViewMode = .always
		return tf
	}()
	private lazy var dateTextField: UITextField =  {
		let tf = UITextField()
		tf.backgroundColor = "#FAFAFA".hexColor()
		tf.layer.cornerRadius = 6
        tf.placeholder = "_ _ . _ _ . _ _"
        tf.keyboardType = .numberPad
		// Create left padding view
		let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.leftView = leftPaddingView
		tf.leftViewMode = .always
        tf.addTarget(self, action: #selector(textChangedDate(_:)), for: .editingChanged)

		// Create right padding view
		let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.rightView = rightPaddingView
		tf.rightViewMode = .always
		return tf
	}()


	private var AllergiesAndIntolerancesLabel: UILabel = {
		let label = UILabel()
		label.text = "Місце події"
		label.textColor = "#333333".hexColor()
		label.font = .interMedium(size: 14)
        label.setWidth(24)
		return label
	}()
	
	private var AllergiesAndIntolerancesTextView: CustomTextView = {
		let tv = CustomTextView()
		tv.placeholder = ""
		tv.placeholderTextColor = .lightGray
		tv.cornerRadius = 8
		tv.borderWidth = 1
		tv.borderColor = UIColor.lightGray
		tv.textPadding = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
		tv.customFont = UIFont.systemFont(ofSize: 16)
		tv.customTextColor = .black
        tv.setHeight(78)
		return tv
	}()
	  //MARK: - Init
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	private func configureUI() {
		backgroundColor = .white
		addSubViews()
		placeOfCombatLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 24)
        AllergiesAndIntolerancesLabel.anchor(top: placeOfCombatLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        AllergiesAndIntolerancesTextView.anchor(top: AllergiesAndIntolerancesLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingRight: 16)

        timeDateLabel.anchor(top: AllergiesAndIntolerancesTextView.bottomAnchor, left: leftAnchor,  paddingTop: 12, paddingLeft: 16, width: 88, height: 48)
        timeTextField.anchor(top: timeDateLabel.topAnchor, left: timeDateLabel.rightAnchor, width: 83,  height: 48)
        dateTextField.anchor(top: timeTextField.topAnchor, left: timeTextField.rightAnchor,  paddingLeft: 8, width: 135, height: 48)
	}
	private func addSubViews() {
		addSubview(placeOfCombatLabel)
		addSubview(numberOperationTextField)
		addSubview(timeDateLabel)
		addSubview(timeTextField)
		addSubview(dateTextField)
		addSubview(AllergiesAndIntolerancesLabel)
		addSubview(AllergiesAndIntolerancesTextView)
	}
    private func applyMaskTime(to text: String) -> String {
        let cleanedText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = cleanedText.startIndex
        let mask = "XX:XX"
        
        for char in mask {
            if index >= cleanedText.endIndex {
                break
            }
            if char == "X" {
                result.append(cleanedText[index])
                index = cleanedText.index(after: index)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
    private func applyMaskDate(to text: String) -> String {
        let cleanedText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = cleanedText.startIndex
        let mask = "XX.XX.XX"
        
        for char in mask {
            if index >= cleanedText.endIndex {
                break
            }
            if char == "X" {
                result.append(cleanedText[index])
                index = cleanedText.index(after: index)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
    @objc
    func textChangedTime(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let text = textField.text {
               textField.text = applyMaskTime(to: text)
           }
      
    }
    @objc
    func textChangedDate(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let text = textField.text {
               textField.text = applyMaskDate(to: text)
           }
      
    }


}
#Preview() {
    MainInfoControllerViewController()
}
