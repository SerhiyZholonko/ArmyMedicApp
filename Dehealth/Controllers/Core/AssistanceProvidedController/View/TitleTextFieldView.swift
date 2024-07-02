//
//  TitleTextFieldView.swift
//  Dehealth
//
//  Created by apple on 11.06.2024.
//

import UIKit
protocol TitleTextFieldViewDelegate: AnyObject {
    func getText(_ text: String, with style: TitleTextFieldViewStyle)
}
enum TitleTextFieldViewStyle {
    case volume
    case time
}
class TitleTextFieldView: UIView {
     //MARK: - Properties
    
    weak var delegate: TitleTextFieldViewDelegate?
    private let style: TitleTextFieldViewStyle
    var isTime: Bool = false
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Title"
        label.font = .interLight(size: 14)
        label.setHeight(24)
        return label
    }()
    private lazy var inputTextField: UITextField = {
        let tf = UITextField()
          tf.backgroundColor = .black0
          tf.setHeight(48)
          tf.layer.borderColor = UIColor.black200!.cgColor
          tf.layer.borderWidth = 1
          tf.layer.cornerRadius = 6
          let view = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 30))
          tf.leftViewMode = .always
          tf.rightViewMode = .always
          tf.leftView = view
          tf.rightView = view
          tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(textChangedTime(_:)), for: .editingChanged)
          return tf
      }()
     //MARK: - Init
    init(frame: CGRect, style: TitleTextFieldViewStyle) {
        self.style = style
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    func setParameters(title: String) {
        titleLabel.text = title
    }
    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor)
        addSubview(inputTextField)
        inputTextField.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    private func applyMaskTime(to text: String) -> String {
        let cleanedText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = cleanedText.startIndex
        let mask = isTime ? "XX:XX" : "XXXX"
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
            delegate?.getText(text, with: self.style)
           }
      
    }
    
}


#Preview() {
    AssistanceProvidedController()
}
