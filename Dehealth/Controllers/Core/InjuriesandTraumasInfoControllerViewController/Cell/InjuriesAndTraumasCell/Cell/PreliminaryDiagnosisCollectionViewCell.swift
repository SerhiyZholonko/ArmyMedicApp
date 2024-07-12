//
//  PreliminaryDiagnosisCollectionViewCell.swift
//  Dehealth
//
//  Created by apple on 02.07.2024.
//

import UIKit

protocol PreliminaryDiagnosisCollectionViewCellDelegate: AnyObject {
    func changeDiagnose(_ text: String)
}
class PreliminaryDiagnosisCollectionViewCell :UICollectionViewCell {
     //MARK: - Properties
    static let identifier = "PreliminaryDiagnosisCollectionViewCell"
    weak var delegate: PreliminaryDiagnosisCollectionViewCellDelegate?

    private let bgView: UIView = {
       let view = UIView()
        view.backgroundColor = .black150
        view.layer.cornerRadius = 8
        return view
    }()
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Попередній діагноз"
        label.font = .interMedium(size: 14)
        return label
    }()
    private let diagnoseLabel: UILabel = {
       let label = UILabel()
        label.font = .interLight(size: 14)
        label.numberOfLines = 0
        return label
    }()
     //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    func configureCell(viewModel: InjuriesandTraumasInfoViewControllerViewModel) {
        diagnoseLabel.text = viewModel.preliminaryDiagnosis
    }
    private func configureUI() {
        backgroundColor = .clear
        addSubview(bgView)
        bgView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        addSubview(titleLabel)
        titleLabel.anchor(top: bgView.topAnchor, left: bgView.leftAnchor, paddingTop: 8, paddingLeft: 16, height: 24)
        addSubview(diagnoseLabel)
        diagnoseLabel.anchor(top: titleLabel.bottomAnchor, left: bgView.leftAnchor, bottom: bgView.bottomAnchor, right: bgView.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 12, paddingRight: 8)
    }
    private func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(textWillChange))
        bgView.addGestureRecognizer(tap)
    }
   @objc
    private func textWillChange() {
        if let diagnoseText = diagnoseLabel.text {
            delegate?.changeDiagnose(diagnoseText)
        }
    }
    
}


