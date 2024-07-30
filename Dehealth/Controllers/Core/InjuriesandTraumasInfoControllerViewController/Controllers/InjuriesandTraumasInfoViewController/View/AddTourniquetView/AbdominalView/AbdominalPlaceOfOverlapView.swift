//
//  AbdominalPlaceOfOverlapView.swift
//  Dehealth
//
//  Created by apple on 15.07.2024.
//
//


import UIKit

protocol AbdominalPlaceOfOverlapViewDelegate: AnyObject {
    func getTitleOfSelect(_ title: Int)
    func updateViewModel(_ viewModel: AddTourniquetViewViewModel)
    func update(_ time: String)
    func update(limb: Int)
    func update(_ type: Int, state: Int)
    func typeTurnstile(_ turnstile: String)
}

class AbdominalPlaceOfOverlapView: UIView {
    // MARK: - Properties
    private var viewModel: AddTourniquetViewViewModel
    
    weak var delegate: AbdominalPlaceOfOverlapViewDelegate?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Місце накладання *"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    private lazy var typeOfTurnstileView: TypeOfTurnstileView = {
        let view = TypeOfTurnstileView()
        view.delegate = self
        return view
    }()
    private lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: GroinLeftOrRightSegment.allCases.map { $0.title })
        sc.backgroundColor = .white
        sc.selectedSegmentTintColor = .clear // Set to clear to apply custom image
        sc.setBackgroundImage(UIImage(color: .black700!), for: .selected, barMetrics: .default)
        sc.setBackgroundImage(UIImage(color: .black200!), for: .normal, barMetrics: .default)
        sc.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        sc.setTitleTextAttributes(normalTextAttributes, for: .normal)
        sc.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        sc.setHeight(48)
        sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        sc.selectedSegmentIndex = UISegmentedControl.noSegment
        return sc
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
    // MARK: - Enums
    enum GroinLeftOrRightSegment: Int, CaseIterable {
        case abdomen
        var title: String {
            switch self {
            case .abdomen: return "Живіт"
            }
        }
    }
    
    // MARK: - Init
    init(frame: CGRect, viewModel: AddTourniquetViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        configureUI()
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Functions
    func updateSegmentedControl() {
        timeTurnstileView.updateTimeTextField()
        typeOfTurnstileView.updateLabel()
        segmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
    }
    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, height: 24)
        
        addSubview(segmentedControl)
        segmentedControl.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, right: rightAnchor, paddingTop: 8, height: 48)
        
        addSubview(typeOfTurnstileView)
        typeOfTurnstileView.anchor(top: segmentedControl.bottomAnchor, left: segmentedControl.leftAnchor, right: segmentedControl.rightAnchor, paddingTop: 24, height: 76)
        
        addSubview(overlapTimeLabel)
        overlapTimeLabel.anchor(top: typeOfTurnstileView.bottomAnchor, left: typeOfTurnstileView.leftAnchor, paddingTop: 24, height: 24)
        
        addSubview(timeTurnstileView)
        timeTurnstileView.anchor(top: overlapTimeLabel.bottomAnchor, left: overlapTimeLabel.leftAnchor, paddingTop: 4, width: 149, height: 48)
        
        addSubview(typeOfTurnstileTableView)
        typeOfTurnstileTableView.anchor(top: typeOfTurnstileView.bottomAnchor, left: typeOfTurnstileView.leftAnchor, right: typeOfTurnstileView.rightAnchor, height: 168)
    }
    
    private func configureTableView() {
        typeOfTurnstileTableView.delegate = self
        typeOfTurnstileTableView.dataSource = self
        typeOfTurnstileTableView.register(TypeOfTrainingViewCell.self, forCellReuseIdentifier: TypeOfTrainingViewCell.identifier)
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        if let title = sender.titleForSegment(at: sender.selectedSegmentIndex), title == GroinLeftOrRightSegment.abdomen.title {
            if title == "Живіт" {
//                delegate?.getTitleOfSelect(0)
                delegate?.update(limb: 0)
            }
        }
    }
    func dismissDropView() {
        self.typeOfTurnstileTableView.alpha = 0
    }
}



extension AbdominalPlaceOfOverlapView: TimeTurnstileViewDelegate {
    func getTime(_ time: String) {
        delegate?.update(time)
    }
}

extension AbdominalPlaceOfOverlapView: TypeOfTurnstileViewDelegate {
    func getTypeOfTurnstile() {
        viewModel.isTypeOfTurnstileForAbdominal.toggle()
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.typeOfTurnstileTableView.alpha = self.viewModel.isTypeOfTurnstileForAbdominal ? 1 : 0
        }
    }
}
//MARK: - Delegate table view
extension AbdominalPlaceOfOverlapView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.typeOfTurnstileListForAbdominal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TypeOfTrainingViewCell.identifier, for: indexPath) as! TypeOfTrainingViewCell
        let typeOfTurnstileString = viewModel.typeOfTurnstileListForAbdominal[indexPath.row]
        cell.setTitle(typeOfTurnstileString)
        cell.accessoryType = indexPath == viewModel.selectedIndex ? .checkmark : .none
        cell.tintColor = .black700
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let typeOfTurnstileString = viewModel.typeOfTurnstileListForAbdominal[indexPath.row]
        delegate?.update(indexPath.row, state: 2)
        delegate?.typeTurnstile(typeOfTurnstileString)
        delegate?.update(limb: indexPath.row)
        viewModel.getIndex(indexPath)
        viewModel.selectedIndex = indexPath
        
        typeOfTurnstileView.setTitle(typeOfTurnstileString)
        
        getTypeOfTurnstile()
        
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}


