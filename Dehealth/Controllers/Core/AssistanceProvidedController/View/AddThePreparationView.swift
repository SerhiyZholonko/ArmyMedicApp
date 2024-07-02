//
//  AddThePreparationView.swift
//  Dehealth
//
//  Created by apple on 11.06.2024.
//

import UIKit

protocol AddThePreparationViewDelegate: AnyObject {
    func getNewPreparation(_ medicine: Medicine)
    func closeButtonDidTap()
}

class AddThePreparationView: UIView {
    // MARK: - Parameters
    private var viewModel = AddThePreparationViewViewModel()
    weak var delegate: AddThePreparationViewDelegate?
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black0
        view.layer.cornerRadius = 16
        view.setHeight(436)
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Додайте препарат"
        label.font = .interMedium(size: 20)
        label.textColor = "#1D1D1F".hexColor()
        return label
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Close"), for: .normal)
        button.tintColor = .black600
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        return button
    }()
    private let nameDrugLabel: UILabel = {
        let label = UILabel()
        label.text = "Назва ліків, розчину чи препарату крові"
        label.font = .interLight(size: 14)
        label.textColor = .black700
        return label
    }()
    private lazy var nameDrugTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .black0
        tf.setHeight(48)
        tf.layer.borderColor = UIColor.black200?.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 6
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 30))
        tf.leftViewMode = .always
        tf.rightViewMode = .always
        tf.leftView = view
        tf.rightView = view
        tf.addTarget(self, action: #selector(textChangedTime(_:)), for: .editingChanged)
        return tf
    }()
    private lazy var volumeView: TitleTextFieldView = {
        let view = TitleTextFieldView(frame: .zero, style: .volume)
        view.setParameters(title: "Об’єм (мг)")
        view.isTime = false
        view.delegate = self
        return view
    }()
    private lazy var timeView: TitleTextFieldView = {
        let view = TitleTextFieldView(frame: .zero, style: .time)
        view.setParameters(title: "Час")
        view.isTime = true
        view.delegate = self
        return view
    }()
    private lazy var inputPath: TitleAndPikerView = {
        let view = TitleAndPikerView()
        view.setTitle("Шлях введення")
        view.delegate = self
        return view
    }()
    private lazy var dropView: PathDropView = {
        let view = PathDropView()
        view.alpha = 0
        view.delegate = self
        return view
    }()
    private lazy var buttonsStackView: CancelAddButtonsView = {
        let sv = CancelAddButtonsView(frame: .zero)
        sv.delegate = self
        return sv
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        bgView.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Override the alpha property
    override var alpha: CGFloat {
        didSet {
            if alpha == 1.0 {
                nameDrugTextField.becomeFirstResponder()
            }
        }
    }
    
    // MARK: - Functions
    func nameDrugTextFieldFirsResponder() {
        nameDrugTextField.resignFirstResponder()
    }
    private func configureUI() {
        backgroundColor = .black700?.withAlphaComponent(0.7)
        addSubview(bgView)
        bgView.centerY(inView: self, constant: -100)
        bgView.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 20, paddingRight: 20)
        addSubview(titleLabel)
        titleLabel.anchor(top: bgView.topAnchor, left: bgView.leftAnchor, paddingTop: 24, paddingLeft: 24)
        
        addSubview(closeButton)
        closeButton.anchor(top: bgView.topAnchor, right: bgView.rightAnchor, paddingTop: 24, paddingRight: 24, width: 24, height: 32)
        
        addSubview(nameDrugLabel)
        nameDrugLabel.anchor(top: titleLabel.bottomAnchor, left: bgView.leftAnchor, right: bgView.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingRight: 24)
        addSubview(nameDrugTextField)
        nameDrugTextField.anchor(top: nameDrugLabel.bottomAnchor, left: nameDrugLabel.leftAnchor, right: nameDrugLabel.rightAnchor, paddingTop: 4)
        addSubview(volumeView)
        addSubview(timeView)
        timeView.anchor(top: nameDrugTextField.bottomAnchor, right: nameDrugTextField.rightAnchor, width: 100, height: 76)
        volumeView.anchor(top: nameDrugTextField.bottomAnchor, left: nameDrugTextField.leftAnchor, right: timeView.leftAnchor, paddingRight: 16, height: 76)
        addSubview(inputPath)
        inputPath.anchor(top: volumeView.bottomAnchor, left: volumeView.leftAnchor, right: timeView.rightAnchor, paddingTop: 12, height: 80)
        addSubview(buttonsStackView)
        buttonsStackView.anchor(top: inputPath.bottomAnchor, right: bgView.rightAnchor, paddingTop: 24, paddingRight: 24, width: 232, height: 48)
        addSubview(dropView)
        dropView.anchor(top: inputPath.bottomAnchor, left: inputPath.leftAnchor, bottom: bottomAnchor, right: inputPath.rightAnchor)
    }
    
    @objc
    private func saveButtonDidTap() {
        
    }
    @objc
    private func closeButtonDidTap() {
        delegate?.closeButtonDidTap()
    }
    @objc
    func dismissKeyboard() {
        self.endEditing(true)
    }
}

// Delegate textField

extension AddThePreparationView {
    @objc
    func textChangedTime(_ textField: UITextField) {
        guard let text = textField.text else { return }
        viewModel.name = text
    }
}

extension AddThePreparationView: TitleTextFieldViewDelegate {
    func getText(_ text: String, with style: TitleTextFieldViewStyle) {
        switch style {
            
        case .volume:
            viewModel.volume = text
        case .time:
            viewModel.time = text
        }
    }
    
    
    
}
extension AddThePreparationView: TitleAndPikerViewDelegate {
    func DoesPikerOpen() {
        UIView.animate(withDuration: 0.4) {
            self.dropView.alpha = self.dropView.alpha == 0 ? 1 : 0
            
            self.endEditing(true)
        }
    }
}

extension AddThePreparationView: PathDropViewDelegate {
    func inputPathSelected(title: String) {
        viewModel.customMethod = title
        inputPath.setTitleForDropBox(title)
        UIView.animate(withDuration: 0.4) {
            self.dropView.alpha = self.dropView.alpha == 0 ? 1 : 0
            self.endEditing(true)
        }
    }
}

extension AddThePreparationView: CancelAddButtonsViewDelegate {
    func cancelButtonDidTap() {
        delegate?.closeButtonDidTap()
    }
    func addButtonDidTap() {
            if let medicine = viewModel.getMedicine() {
                delegate?.getNewPreparation(medicine)
        }
    }
}
//#Preview() {
//    AssistanceProvidedController()
//}
