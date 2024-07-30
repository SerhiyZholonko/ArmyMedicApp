//
//  NodalView.swift
//  Dehealth
//
//  Created by apple on 12.07.2024.
//

import UIKit
protocol NodalViewDelegate: AnyObject {
    func update(viewModel: AddTourniquetViewViewModel)
    func dismissTableView()
    func update(_ time: String)
    func update(_ limb: Int)
}

class NodalView: UIView {
     //MARK: - Properties
    weak var delegate: NodalViewDelegate?
    private var viewModel: AddTourniquetViewViewModel
    private lazy var groinPlaceOfOverlapView: GroinPlaceOfOverlapView = {
       let view = GroinPlaceOfOverlapView()
        view.delegate = self
        return view
    }()
    private lazy var typeOfTurnstileView: TypeOfTurnstileView = {
        let view = TypeOfTurnstileView()
        view.delegate = self
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
    
    private let typeOfTurnstileTableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.layer.cornerRadius = 12
        tv.alpha = 0
        return tv
    }()

     //MARK: - Init
     init(frame: CGRect, viewModel: AddTourniquetViewViewModel) {
         self.viewModel = viewModel
        super.init(frame: frame)
        configureUI()
//        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    func setupTypeLabel(_ text: String) {
        typeOfTurnstileView.setTitle(text)
    }
    func updateData() {
        timeTurnstileView.updateTimeTextField()
        typeOfTurnstileView.updateLabel()
        groinPlaceOfOverlapView.updateSegmentedControl()
    }
    private func configureUI() {
        backgroundColor = .white
        addSubview(groinPlaceOfOverlapView)
        groinPlaceOfOverlapView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 24, height: 128)
        addSubview(typeOfTurnstileView)
        typeOfTurnstileView.anchor(top: groinPlaceOfOverlapView.bottomAnchor, left: groinPlaceOfOverlapView.leftAnchor, right: groinPlaceOfOverlapView.rightAnchor, paddingTop: 24, height: 76)
        
        addSubview(overlapTimeLabel)
        overlapTimeLabel.anchor(top: typeOfTurnstileView.bottomAnchor, left: typeOfTurnstileView.leftAnchor,  paddingTop: 24, height: 24)
        addSubview(timeTurnstileView)
        timeTurnstileView.anchor(top: overlapTimeLabel.bottomAnchor, left: overlapTimeLabel.leftAnchor, paddingTop: 4, width: 149, height: 48)
    }
}

//MARK: - Delegate

extension NodalView: TypeOfTurnstileViewDelegate {
    func getTypeOfTurnstile() {
        viewModel.isTypeOfTurnstileForNodal.toggle()
        delegate?.dismissTableView()
    }
}


extension NodalView: GroinPlaceOfOverlapViewDelegate{
    func getTitleOfSelect(_ title: Int) {
        viewModel.limb = title
        delegate?.update(title)
    }
}


extension NodalView: TimeTurnstileViewDelegate {
    func getTime(_ time: String) {
        viewModel.time = time
        delegate?.update(time)
    }
    
    
}
