//
//  TimeAndTypeOfTrainingView.swift
//  Dehealth
//
//  Created by apple on 08.07.2024.
//

import UIKit

protocol TypeOfTrainingViewDelegate: AnyObject {
    func setMethod(_ method: PikerStage)
    func getTime(_ time: String)
}

class TypeOfTrainingView: UIView {
     //MARK: - Properties
    weak var delegate: TypeOfTrainingViewDelegate?
    private let typeOfTrainingLabel: UILabel = {
       let label = UILabel()
        label.text = "Тип накладання"
        label.font = .interLight(size: 14)
        return label
    }()
    private lazy var typeRadioButtonsView: VerticalPikerView = {
       let view = VerticalPikerView()
        view.delegate = self
        view.isUserInteractionEnabled = true
        return view
    }()
    private let overlapTimeLabel: UILabel = {
       let label = UILabel()
        label.text = "Час накладання"
        label.font = .interLight(size: 14)
        return label
    }()
    private lazy var timeTurnstileView: TimeTurnstileView = {
       let view = TimeTurnstileView()
        view.delegate = self
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
    func selectFirstButton() {
        typeRadioButtonsView.selectDefaultButton(.pikedOne)
    }
    private func configureUI() {
       addSubview(typeOfTrainingLabel)
        typeOfTrainingLabel.anchor(top: topAnchor, left: leftAnchor, width: 133.95, height: 24)
        addSubview(typeRadioButtonsView)
        typeRadioButtonsView.anchor(top: typeOfTrainingLabel.bottomAnchor, left: typeOfTrainingLabel.leftAnchor, width: 124, height: 60)
        addSubview(overlapTimeLabel)
        overlapTimeLabel.anchor(top: topAnchor, left: typeOfTrainingLabel.rightAnchor, paddingLeft: 35.5, height: 24)
        addSubview(timeTurnstileView)
        timeTurnstileView.anchor(top: overlapTimeLabel.bottomAnchor, left: overlapTimeLabel.leftAnchor,  paddingTop: 4, width: 149, height: 48)
    }
}

extension TypeOfTrainingView: VerticalPikerViewDelegate {
    func setTypeForMethod(_ point: PikerStage) {
        delegate?.setMethod(point)
    }
}


extension TypeOfTrainingView: TimeTurnstileViewDelegate {
    func getTime(_ time: String) {
        delegate?.getTime(time)
    }
    
}
