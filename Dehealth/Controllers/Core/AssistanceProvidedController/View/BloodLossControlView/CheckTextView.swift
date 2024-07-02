//
//  CheckTextView.swift
//  Dehealth
//
//  Created by apple on 12.06.2024.
//

import UIKit

protocol CheckTextViewDelegate: AnyObject {
    func didTap()
}

class CheckTextView: UIView {
    // MARK: - Properties
    weak var delegate: CheckTextViewDelegate?
    private let pikerView: UIImageView = {
        let image = UIImage(named: "Empty")
        let iv = UIImageView(image: image)
        iv.isUserInteractionEnabled = true // Enable user interaction
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    private func configureUI() {
        addSubview(pikerView)
        // Assuming you have an anchor extension or setting constraints manually
        pikerView.translatesAutoresizingMaskIntoConstraints = false
        pikerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pikerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        pikerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        pikerView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: pikerView.rightAnchor, constant: 12).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
   
}
#Preview() {
    AssistanceProvidedController()
}

