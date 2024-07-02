//
//  TitleAndPikerView.swift
//  Dehealth
//
//  Created by apple on 11.06.2024.
//

import UIKit

protocol TitleAndPikerViewDelegate: AnyObject {
    func DoesPikerOpen()
}

class TitleAndPikerView: UIView {
     //MARK: - Parameters
    weak var delegate: TitleAndPikerViewDelegate?
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Title"
        label.font = .interLight(size: 14)
        return label
    }()
    private let selectFromList: DropdownSelectionView = {
        let view = DropdownSelectionView()
        view.setHeight(48)
        view.setupTitle("Виберіть зі списку")
        return view
    }()
     //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureSelectFromList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     //MARK: - Functions
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    func setTitleForDropBox(_ title: String) {
        selectFromList.setupTitle(title)
    }
    private func configureSelectFromList() {
        selectFromList.delegate = self
    }
    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, height: 24)
        addSubview(selectFromList)
        selectFromList.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, right: rightAnchor)

    }
    
    
}


extension TitleAndPikerView: DropdownSelectionViewDelegate {
    func noteShowDropBox() {
        
    }
    
    func bloodLoseShowDropBox() {
        delegate?.DoesPikerOpen()

    }
    
   
    
    func devicesForBreathingShowDropBox() {
        
    }
    
    
    
}

#Preview() {
    AssistanceProvidedController()
}
