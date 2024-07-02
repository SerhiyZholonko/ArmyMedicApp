//
//  PreliminaryDiagnosisView.swift
//  Dehealth
//
//  Created by apple on 23.05.2024.
//

import UIKit

class PreliminaryDiagnosisView: UIView {
     //MARK: - Properties
    private let preliminaryDiagnosisLabel: UILabel = {
       let label = UILabel()
        label.text = "Попередній діагноз"
        return label
    }()
    
     //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    private func configureUI() {
        
    }
}
