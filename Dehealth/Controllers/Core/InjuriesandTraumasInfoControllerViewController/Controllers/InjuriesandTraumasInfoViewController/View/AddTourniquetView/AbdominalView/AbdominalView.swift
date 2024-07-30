//
//  AbdominalView.swift
//  Dehealth
//
//  Created by apple on 15.07.2024.
//

import UIKit

protocol AbdominalViewDelegate: AnyObject {
//    func updateViewModel(_ viewModel: AddTourniquetViewViewModel)
    func updateTime(_ time: String)
    func updateLimb(_ limb: Int)
    func updateType(_ type: Int, state: Int)
    func typeTurnstile(_ turnstile: String)
}

class AbdominalView: UIView {
     //MARK: - Properties
    weak var delegate: AbdominalViewDelegate?
    private var viewModel: AddTourniquetViewViewModel
    private lazy var abdominalPlaceOfOverlapView: AbdominalPlaceOfOverlapView = {
        let view = AbdominalPlaceOfOverlapView(frame: .zero, viewModel: viewModel)
        view.delegate = self
        return view
    }()
     //MARK: - Init
    init(frame: CGRect, viewModel: AddTourniquetViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame
        )
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    func dismissDropView() {
        abdominalPlaceOfOverlapView.dismissDropView()
    }
    func updateSegmentedControl() {
        abdominalPlaceOfOverlapView.updateSegmentedControl()
    }
    private func configureUI() {
        backgroundColor = .white
        addSubview(abdominalPlaceOfOverlapView)
        abdominalPlaceOfOverlapView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 24)
    }
}

extension AbdominalView: AbdominalPlaceOfOverlapViewDelegate {
    func update(_ type: Int, state: Int) {
        delegate?.updateType(type, state: state)

    }
    
    func typeTurnstile(_ turnstile: String) {
        delegate?.typeTurnstile(turnstile)
    }
    
    func getTitleOfSelect(_ title: Int) {
//        delegate?.updateLimb(title)
    }
    func updateViewModel(_ viewModel: AddTourniquetViewViewModel) {
        
    }
    func update(_ time: String) {
        delegate?.updateTime(time)
    }
    func update(limb: Int) {
        delegate?.updateLimb(limb)

    }
}
