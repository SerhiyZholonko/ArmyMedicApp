//
//  SpecifyTheExactLocationView.swift
//  Dehealth
//
//  Created by apple on 11.07.2024.
//

import UIKit

protocol SpecifyTheExactLocationViewDelegate: AnyObject {
    func changeToBig()
}

class SpecifyTheExactLocationView: UIView {
     //MARK: - Properties
    //Tourniquet
    weak var delegate: SpecifyTheExactLocationViewDelegate?
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Вкажіть точне розташування *"
        label.font = .interLight(size: 14)
        return label
    }()
    private let tourniquetImageView: UIImageView = {
        let image = UIImage(named: "Tourniquet")
       let iv = UIImageView(image: image)
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = true
        return iv
    }()
     //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    private func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tourniquetImageViewDidTap))
        tourniquetImageView.addGestureRecognizer(tap)
    }
    private func configureUI() {
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, height: 24)
        addSubview(tourniquetImageView)
        tourniquetImageView.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8)
    }
    @objc
    func tourniquetImageViewDidTap() {
        delegate?.changeToBig()
        print("tourniquetImageViewDidTap")
    }
}

