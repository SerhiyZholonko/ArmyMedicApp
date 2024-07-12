//
//  TimeTurnstileView.swift
//  Dehealth
//
//  Created by apple on 08.07.2024.
//

import UIKit

protocol TimeTurnstileViewDelegate: AnyObject {
    func getTime(_ time: String)
}

class TimeTurnstileView: UIView {
     //MARK: - Properties
    weak var delegate: TimeTurnstileViewDelegate?
    private lazy var timeTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .black100!
        tf.layer.cornerRadius = 6
        tf.layer.borderColor = UIColor.black200!.cgColor
        tf.layer.borderWidth = 1
        // Add padding to the left
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: tf.frame.height))
        tf.leftView = leftPaddingView
        tf.leftViewMode = .always
        
        // Add padding to the right
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: tf.frame.height))
        tf.rightView = rightPaddingView
        tf.rightViewMode = .always
        tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(textChangedTime(_:)), for: .editingChanged)
        return tf
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
        addSubview(timeTextField)
        timeTextField.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
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
     @objc
      func textChangedTime(_ textField: UITextField) {
          guard let text = textField.text else { return }
          if let text = textField.text {
                 textField.text = applyMaskTime(to: text)
              delegate?.getTime(text)
             // delegate?.getText(text, with: self.style)
             }
        
      }
}
