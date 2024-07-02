//
//  SignsAndSymptomsCell.swift
//  Dehealth
//
//  Created by apple on 03.06.2024.
//

import UIKit

class SignsAndSymptomsCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "SignsAndSymptomsCell"
    private lazy var signsAndSymptomsLabel = CustomLabel(textLabel: "Ознаки та симптоми", textColorLabel: .black, fontLabel: .interBold(size: 18))
    private lazy var signsAndSymptomsButton = CustomButton( image: UIImage(named: "plus"), customFont: .interMedium(size: 14))
    private lazy var signsAndSymptomsCollectionView: MedicinesAndDrugsCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = MedicinesAndDrugsCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
        configureUI()
        prepareCollectionView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureUI() {
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 16, paddingBottom: 10, paddingRight: 16)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        
        addSubview(signsAndSymptomsLabel)

        signsAndSymptomsLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor,paddingTop: 16, paddingLeft: 16)
        signsAndSymptomsLabel.anchor(height: 24)
        addSubview(signsAndSymptomsButton)
        signsAndSymptomsButton.centerY(inView: signsAndSymptomsLabel, rightAnchor: contentView.rightAnchor, paddingRight: 16)
        signsAndSymptomsButton.anchor( height: 32)
        
        addSubview(signsAndSymptomsCollectionView)
        signsAndSymptomsCollectionView.anchor(top: signsAndSymptomsLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 8, paddingRight: 16)
    }
    private func configureButton() {
        signsAndSymptomsButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        signsAndSymptomsButton.addTarget(self, action: #selector(signsAndSymptomsButtonDidTap), for: .touchUpInside)

    }
    private func prepareCollectionView() {
        signsAndSymptomsCollectionView.register(SignsAndSymptomsCollectionViewCell.self, forCellWithReuseIdentifier:SignsAndSymptomsCollectionViewCell.identifier)
    }
   @objc
    private func signsAndSymptomsButtonDidTap() {
        print("Tap")
    }
}

extension SignsAndSymptomsCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignsAndSymptomsCollectionViewCell.identifier, for: indexPath) as! SignsAndSymptomsCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 52)
    }
    
}

#Preview() {
    AssistanceProvidedController()
}


