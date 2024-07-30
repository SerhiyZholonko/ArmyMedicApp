//
//  TypeOfTurnstileView.swift
//  Dehealth
//
//  Created by apple on 05.07.2024.
//

import UIKit

protocol TypeOfTurnstileViewDelegate: AnyObject {
    func getTypeOfTurnstile()
}

class TypeOfTurnstileView: UIView {
     //MARK: - Properties
    weak var delegate: TypeOfTurnstileViewDelegate?
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Тип турнікета"
        label.font = .interLight(size: 14)
        return label
    }()
    private lazy var dropBoxView: UIView = {
       let view = UIView()
        view.backgroundColor = .black100!
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black200!.cgColor
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dropBoxButtonDidTap))
//        view.addGestureRecognizer(tap)
        return view
    }()
    private let dropBoxLabel: UILabel = {
       let label = UILabel()
        label.text = ""
        label.font = .interMedium(size: 16)
        return label
    }()
    private let rectangleImageView: UIImageView = {
        let image = UIImage(named: "triangle")
        let iv = UIImageView(image: image)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private lazy var  dropBoxButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(dropBoxButtonDidTap), for: .touchUpInside)
        return button
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
    func updateLabel() {
        dropBoxLabel.text = ""
    }
    func setTitle(_ title: String) {
        dropBoxLabel.text = title
    }
    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, height: 24)
        addSubview(dropBoxView)
        dropBoxView.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, right:  rightAnchor, height: 48)
        addSubview(dropBoxLabel)
        dropBoxLabel.centerY(inView: dropBoxView, leftAnchor: dropBoxView.leftAnchor, paddingLeft: 12)
        addSubview(rectangleImageView)
        rectangleImageView.centerY(inView: dropBoxView, rightAnchor: dropBoxView.rightAnchor, paddingRight: 17)
        rectangleImageView.anchor(width: 10, height: 5)
        addSubview(dropBoxButton)
        dropBoxButton.anchor(top: dropBoxView.topAnchor, bottom: dropBoxView.bottomAnchor,right: dropBoxView.rightAnchor, width: 80)
    }
    @objc
    private func dropBoxButtonDidTap() {
        delegate?.getTypeOfTurnstile()
    }
    
}
