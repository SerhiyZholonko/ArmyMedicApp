//
//  File.swift
//  Dehealth
//
//  Created by apple on 08.02.2024.
//

import UIKit

protocol MainInfoCellDelegate: AnyObject {
	func markDidTap()
    func setGender(_ gender: Gender)
    func showImagePiker()
}

class MainInfoCell: UICollectionViewCell {

	// MARK: - Properties
	weak var delegate: MainInfoCellDelegate?
	static let identifier = "MainInfoCell"
    

	private let titleIDLabel: UILabel = {
		let label = UILabel()
		label.text = "Основна інформація"
		label.font = .interBold(size: 18)
        label.setWidth(24)
		return label
	}()
	private lazy var photoBGView: UIView = {
		let view = UIView()
		view.backgroundColor = "#EBEDF5".hexColor()
		view.layer.cornerRadius = 8
		view.isUserInteractionEnabled = true // Enable user interaction
        let tap = UITapGestureRecognizer(target: self, action: #selector(photoBGViewDidTap))
        view.addGestureRecognizer(tap)
		return view
	}()
	private let photoImageView: UIImageView = {
		let image = UIImage(named: "person")
		let iv = UIImageView(image: image)
		return iv
	}()
    private lazy var selectedPhotoImageView: UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true // Enable user interaction
        let tap = UITapGestureRecognizer(target: self, action: #selector(photoBGViewDidTap))
        iv.addGestureRecognizer(tap)
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
	private let addPhotoLabel: UILabel = {
		let label = UILabel()
		label.text = "+ Додати фото"
		label.textColor = "#5E42EC".hexColor()
		label.font = .interMedium(size: 14)
		return label
	}()
	private let numberIDLabel: UILabel = {
		let label = UILabel()
		label.text = "ID номер"
		label.textColor = "#333333".hexColor()
		label.font = .interMedium(size: 14)
		return label
	}()
	private lazy var numberIDTextField: UITextField = {
		let tf = UITextField()
		tf.backgroundColor = "#FAFAFA".hexColor()
		tf.layer.cornerRadius = 6
        tf.font = .interBold(size: 24)
		// Create left padding view
		let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.leftView = leftPaddingView
		tf.leftViewMode = .always
		// Create right padding view
		let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.rightView = rightPaddingView
		tf.rightViewMode = .always
        tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
		return tf
	}()

	private let titleBirthdayLabel: UILabel = {
		let label = UILabel()
		label.text = "Дата народження"
		label.textColor = "#333333".hexColor()
		label.font = .interMedium(size: 14)
		return label
	}()

	private lazy var birthdayTextField: UITextField = {
		let tf = UITextField()
		tf.backgroundColor = "#FAFAFA".hexColor()
		tf.layer.cornerRadius = 6
        tf.font = .interBold(size: 16)
        tf.placeholder = "_ _._ _._ _ _ _"
		// Create left padding view
		let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.leftView = leftPaddingView
		tf.leftViewMode = .always

		// Create right padding view
		let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
		tf.rightView = rightPaddingView
		tf.rightViewMode = .always
        tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(textChangedBirthday(_:)), for: .editingChanged)
		return tf
	}()
	private let surnameLabel: UILabel = {
		let label = UILabel()
		label.text = "Прізвише"
		label.textColor = "#333333".hexColor()
		label.font = .interMedium(size: 14)
		return label
	}()
	
	private let surnameTextField: UITextField = {
		let tf = UITextField()
		tf.backgroundColor = "#FAFAFA".hexColor()
		tf.layer.cornerRadius = 6
        tf.font = .interMedium(size: 16)
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
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ім’я"
        label.textColor = "#333333".hexColor()
        label.font = .interMedium(size: 14)
        return label
    }()
    
    private let nameTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = "#FAFAFA".hexColor()
        tf.layer.cornerRadius = 6
        tf.font = .interMedium(size: 16)
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
    private let middleNameLabel: UILabel = {
        let label = UILabel()
        label.text = "По батьку"
        label.textColor = "#333333".hexColor()
        label.font = .interMedium(size: 14)
        return label
    }()

    private let middleNameTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = "#FAFAFA".hexColor()
        tf.layer.cornerRadius = 6
        tf.font = .interMedium(size: 16)
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
    private lazy var genderView: GenderView = {
        let view = GenderView()
        view.delegate = self
        return view
    }()
    
    private let indexNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "ІПН"
        label.textColor = "#333333".hexColor()
        label.font = .interMedium(size: 14)
        return label
    }()

    private let indexNumberTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = "#FAFAFA".hexColor()
        tf.layer.cornerRadius = 6
        tf.font = .interMedium(size: 16)
        tf.keyboardType = .numberPad
        // Create left padding view
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = leftPaddingView
        tf.leftViewMode = .always
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.rightView = rightPaddingView
        tf.rightViewMode = .always
        return tf
    }()
    private var AllergiesAndIntolerancesLabel: UILabel = {
        let label = UILabel()
        label.text = "Алергія та непереносимість"
        label.textColor = "#333333".hexColor()
        label.font = .interMedium(size: 14)
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
        return tv
    }()
	// MARK: - Lifecycle

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupViews()
	}

	// MARK: - Setup
    func configure(with image: UIImage?) {
        selectedPhotoImageView.image = image
    }
	private func setupViews() {
		// Example: Configure UI elements and add them as subviews
		backgroundColor = .white
		layer.cornerRadius = 8
		layer.borderWidth = 1
		layer.borderColor = UIColor.lightGray.cgColor

		// Add tap gesture recognizer to photoBGView
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoBGViewTapped))
		photoBGView.addGestureRecognizer(tapGesture)

		// Add subviews
		addSubview(titleIDLabel)
		titleIDLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
		addSubview(photoBGView)
		photoBGView.anchor(top: titleIDLabel.bottomAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16, width: 148, height: 176)
		addSubview(photoImageView)
		photoImageView.anchor(top: photoBGView.topAnchor, left: photoBGView.leftAnchor, paddingTop: 48, paddingLeft: 50, width: 48, height: 48)
       
		addSubview(addPhotoLabel)
		addPhotoLabel.anchor(top: photoImageView.bottomAnchor, paddingTop: 20)
		addPhotoLabel.centerX(inView: photoBGView)
        addSubview(selectedPhotoImageView)
        selectedPhotoImageView.anchor(top: photoBGView.topAnchor, left: photoBGView.leftAnchor, bottom: photoBGView.bottomAnchor, right: photoBGView.rightAnchor)
		addSubview(numberIDLabel)
		numberIDLabel.anchor(top: photoBGView.topAnchor, left: photoBGView.rightAnchor, paddingLeft: 24)
		addSubview(numberIDTextField)
		numberIDTextField.anchor(top: numberIDLabel.bottomAnchor, left: numberIDLabel.leftAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 16, height: 48)
		addSubview(titleBirthdayLabel)
		titleBirthdayLabel.anchor(top: numberIDTextField.bottomAnchor, left: numberIDTextField.leftAnchor,  paddingTop: 8)

		addSubview(birthdayTextField)
		birthdayTextField.anchor(top: titleBirthdayLabel.bottomAnchor, left: titleBirthdayLabel.leftAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 16, height: 48)

		addSubview(surnameLabel)
		surnameLabel.anchor(top: photoBGView.bottomAnchor, left: photoBGView.leftAnchor, paddingTop: 20,width: 88, height: 48)
		
		addSubview(surnameTextField)
		surnameTextField.anchor(left: surnameLabel.rightAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 16, height: 48)
        surnameTextField.centerY(inView: surnameLabel)
        addSubview(nameLabel)
        nameLabel.anchor(top: surnameLabel.bottomAnchor, left: photoBGView.leftAnchor, paddingTop: 8,width: 88, height: 48)
        addSubview(nameTextField)
        nameTextField.anchor(left: nameLabel.rightAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 16, height: 48)
        nameTextField.centerY(inView: nameLabel)
        addSubview(middleNameLabel)
        middleNameLabel.anchor(top: nameLabel.bottomAnchor, left: nameLabel.leftAnchor, paddingTop: 8,width: 88, height: 48)
        addSubview(middleNameTextField)
        middleNameTextField.anchor(left: middleNameLabel.rightAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 16, height: 48)
        middleNameTextField.centerY(inView: middleNameLabel)
        addSubview(genderView)
        genderView.anchor(top: middleNameLabel.bottomAnchor, left: nameLabel.leftAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 16, height: 48)
        addSubview(indexNumberLabel)
        indexNumberLabel.anchor(top: genderView.bottomAnchor, left: genderView.leftAnchor, paddingTop: 8,width: 88, height: 48)
        addSubview(indexNumberTextField)
        indexNumberTextField.anchor(left: indexNumberLabel.rightAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 16, height: 48)
        indexNumberTextField.centerY(inView: indexNumberLabel)
        addSubview(AllergiesAndIntolerancesLabel)
        AllergiesAndIntolerancesLabel.anchor(top: indexNumberLabel.bottomAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16, height: 24)
        addSubview(AllergiesAndIntolerancesTextView)
        AllergiesAndIntolerancesTextView.anchor(top: AllergiesAndIntolerancesLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 20, paddingRight: 16, height: 72)

	}
	// MARK: - Configuration


	// MARK: - Gesture Recognizer Action
    private func applyMask(to text: String) -> String {
        let cleanedText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = cleanedText.startIndex
        let mask = "XXX XX XX"
        
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
    private func applyMaskBirthday(to text: String) -> String {
        let cleanedText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = cleanedText.startIndex
        let mask = "XX.XX.XXXX"
        
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
    func textChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let text = textField.text {
               textField.text = applyMask(to: text)
           }
      
    }
    @objc
    func textChangedBirthday(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let text = textField.text {
               textField.text = applyMaskBirthday(to: text)
           }
      
    }
	@objc 
    private func photoBGViewTapped() {
		// Handle tap on photoBGView
		delegate?.markDidTap()
        delegate?.showImagePiker()

	}
    @objc
    private func photoBGViewDidTap() {
        delegate?.showImagePiker()
    }
    
}

extension MainInfoCell: SexViewDelegate {
	func markDidTap() {
		delegate?.markDidTap()
	}
}




extension MainInfoCell: GenderViewDelegate {
    func setGender(_ gender: Gender) {
        delegate?.setGender(gender)
    }
}
#Preview() {
    MainInfoControllerViewController()
}
