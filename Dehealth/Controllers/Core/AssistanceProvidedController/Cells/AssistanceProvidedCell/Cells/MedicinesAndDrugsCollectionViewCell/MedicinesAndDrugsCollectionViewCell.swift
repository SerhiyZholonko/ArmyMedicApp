//
//  MedicinesAndDrugsCollectionViewCell.swift
//  Dehealth
//
//  Created by apple on 05.06.2024.
//

import UIKit

class MedicinesAndDrugsCollectionViewCell: UICollectionViewCell {
     //MARK: - Properties
    private let viewModel = MedicinesAndDrugsCollectionViewCellViewModel()
    static let identifier = "MedicinesAndDrugsCollectionViewCell"
    private let drugNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Морфін"
        label.font = .interSemiBold(size: 16)
        label.setHeight(24)
        return label
    }()
    private let subDrugNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Внутрішньом’язовий"
        label.font = .interLight(size: 10)
        label.setHeight(12)
        return label
    }()
    private let doseLabel: UILabel = {
       let label = UILabel()
        label.text = "100 мг"
        label.font = .interMedium(size: 16)
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:30"
        label.font = .interMedium(size: 16)
        label.setHeight(24)
        label.textAlignment = .right
        return label
    }()
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.text = "24.04.24"
        label.font = .interMedium(size: 10)
        label.setHeight(12)

        return label
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
    func configureCell(model: Medicine) {
        drugNameLabel.text = model.name
        subDrugNameLabel.text = model.customMethod
        doseLabel.text = "\(model.amount) \(model.customMeasure)"
        if let time = viewModel.convertToTimeString(from: model.madeAt) {
            timeLabel.text = time
        }
        
        if let dateString = viewModel.getDateString(from: model.createAt) {
            dateLabel.text = dateString
        }
    }
    private func configureUI() {
        contentView.backgroundColor = .black150
        contentView.layer.cornerRadius = 8
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 4, paddingRight: 16)
        addSubview(drugNameLabel)
        drugNameLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 8, paddingLeft: 12, width: 158)
        addSubview(subDrugNameLabel)
        subDrugNameLabel.anchor(top: drugNameLabel.bottomAnchor, left: drugNameLabel.leftAnchor)
        addSubview(doseLabel)
        doseLabel.anchor(top: drugNameLabel.topAnchor, left: drugNameLabel.rightAnchor, paddingTop: 8)
        addSubview(timeLabel)
        timeLabel.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, paddingTop: 8, paddingRight: 12)
        addSubview(dateLabel)
        dateLabel.anchor(top: timeLabel.bottomAnchor, right: timeLabel.rightAnchor)
    }
//    private func getTimeString(from isoDateString: String) -> String? {
//        let formatter = ISO8601DateFormatter()
//        guard let date = formatter.date(from: isoDateString) else {
//            return nil
//        }
//
//        let timeFormatter = DateFormatter()
//        timeFormatter.dateFormat = "HH:mm"
//        return timeFormatter.string(from: date)
//    }
   

}


