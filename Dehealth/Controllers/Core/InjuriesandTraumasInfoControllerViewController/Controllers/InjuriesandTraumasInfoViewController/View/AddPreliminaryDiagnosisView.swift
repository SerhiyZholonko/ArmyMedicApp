//
//  AddPreliminaryDiagnosisView.swift
//  Dehealth
//
//  Created by apple on 03.07.2024.
//

import UIKit

class AddPreliminaryDiagnosisView: UIView {
     //MARK: - Properties
    private let bgView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
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
        backgroundColor = .black700?.withAlphaComponent(0.7)
        bgView.anchor(left: leftAnchor, right: rightAnchor)
        bgView.centerY(inView: self)
    }
}

