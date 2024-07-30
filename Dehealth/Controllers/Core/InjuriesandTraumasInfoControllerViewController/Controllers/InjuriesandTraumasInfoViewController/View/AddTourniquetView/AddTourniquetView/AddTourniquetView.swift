//
//  AddTourniquetView.swift
//  Dehealth
//
//  Created by apple on 05.07.2024.
//

import UIKit

protocol AddTourniquetViewDelegate: AnyObject {
    func closeBottonDidTap()
    func saveTourniquet(_ tourniquet:Tourniquet)
}

class AddTourniquetView: UIView {
    //MARK: - Properties
    weak var delegate: AddTourniquetViewDelegate?
    private var viewModel = AddTourniquetViewViewModel()
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Турнікет"
        label.font = .interMedium(size: 20)
        return label
    }()
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black600
        button.addTarget(self, action: #selector(closeBottonDidTap), for: .touchUpInside)
        return button
    }()
    private let localBodyPlaceControl = CustomSegmentedControl("Для кінцівок", "Вузловий", "Абдомінальний")
    private lazy var placeOfOverlapView: PlaceOfOverlapView = {
        let view = PlaceOfOverlapView()
        view.delegate = self
        return view
    }()
    private lazy var typeOfTurnstileView: TypeOfTurnstileView = {
        let view = TypeOfTurnstileView()
        view.delegate = self
        return view
    }()
    
    private let typeOfTurnstileTableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.layer.cornerRadius = 12
        tv.alpha = 0
        return tv
    }()
    private let nodalTypeOfTurnstileTableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.layer.cornerRadius = 12
        tv.alpha = 0
        return tv
    }()
    private lazy var typeOfTrainingView: TypeOfTrainingView = {
        let view = TypeOfTrainingView()
        view.delegate = self
        return view
    }()
    private lazy var specifyTheExactLocationView: SpecifyTheExactLocationView = {
        let view = SpecifyTheExactLocationView()
        view.alpha = 0
        view.delegate = self
        return view
    }()
    private let bigSpecifyTheExactLocationView: BigSpecifyTheExactLocationView = {
        let view = BigSpecifyTheExactLocationView()
        view.alpha = 0
        return view
    }()
    
    private lazy var nodalView: NodalView = {
        let view = NodalView(frame: .zero, viewModel: viewModel)
        view.delegate = self
        view.alpha = 0
        return view
    }()
    private lazy var abdominalView: AbdominalView = {
        let view = AbdominalView(frame: .zero, viewModel: viewModel)
        view.delegate = self
        view.alpha = 0
        return view
    }()
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Додати", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .interMedium(size: 16)
        button.backgroundColor = .purple600
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        return button
    }()
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureTableView()
        addGesture()
        configureSegmentControl()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    
    private func configureSegmentControl() {
        localBodyPlaceControl.delegate = self
    }
    private func configureUI() {
        backgroundColor = .black700?.withAlphaComponent(0.7)
        addSubview(bgView)
        bgView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16,  height: 592)
        addSubview(titleLabel)
        titleLabel.anchor(top: bgView.topAnchor, left: bgView.leftAnchor, paddingTop: 16, paddingLeft: 16, height: 32)
        addSubview(closeButton)
        closeButton.anchor(width: 24, height: 24)
        closeButton.centerY(inView: titleLabel, rightAnchor: bgView.rightAnchor, paddingRight: 16)
        addSubview(localBodyPlaceControl)
        localBodyPlaceControl.anchor(top: titleLabel.bottomAnchor, left: bgView.leftAnchor, right: bgView.rightAnchor, paddingTop: 16, paddingLeft: 20, paddingRight: 20, height: 40)
        addSubview(placeOfOverlapView)
        placeOfOverlapView.anchor(top: localBodyPlaceControl.bottomAnchor, left: localBodyPlaceControl.leftAnchor, right: localBodyPlaceControl.rightAnchor, paddingTop: 24, height: 136)
        //
        addSubview(typeOfTrainingView)
        typeOfTrainingView.anchor(top: placeOfOverlapView.bottomAnchor, left: placeOfOverlapView.leftAnchor, right: placeOfOverlapView.rightAnchor, paddingTop: 24, height: 92)
        
        addSubview(typeOfTurnstileView)
        typeOfTurnstileView.anchor(top: typeOfTrainingView.bottomAnchor, left: typeOfTrainingView.leftAnchor, right: typeOfTrainingView.rightAnchor, paddingTop: 24, height: 76)
        
        
        addSubview(addButton)
        addButton.anchor(width: 318, height: 48)
        addButton.centerX(inView: self, topAnchor: typeOfTrainingView.bottomAnchor, paddingTop: 140)
        
        addSubview(specifyTheExactLocationView)
        specifyTheExactLocationView.anchor(top: typeOfTurnstileView.topAnchor, left: typeOfTurnstileView.leftAnchor, bottom: addButton.topAnchor, right: typeOfTurnstileView.rightAnchor, paddingBottom: 16)
        addSubview(typeOfTurnstileTableView)
        typeOfTurnstileTableView.anchor(top: typeOfTurnstileView.bottomAnchor, left: typeOfTurnstileView.leftAnchor, bottom: bottomAnchor, right: typeOfTurnstileView.rightAnchor,  paddingBottom: 9)
        
        addSubview(bigSpecifyTheExactLocationView)
        bigSpecifyTheExactLocationView.anchor(top: titleLabel.bottomAnchor, left: bgView.leftAnchor, bottom: typeOfTurnstileView.topAnchor, right: bgView.rightAnchor, paddingBottom: 24)
        
        addSubview(nodalView)
        nodalView.anchor(top: localBodyPlaceControl.bottomAnchor, left: bgView.leftAnchor, bottom: addButton.topAnchor, right: bgView.rightAnchor, paddingLeft: 20, paddingRight: 20)
        addSubview(nodalTypeOfTurnstileTableView)
        nodalTypeOfTurnstileTableView.anchor(top:  bgView.bottomAnchor, left: typeOfTurnstileTableView.leftAnchor, right: typeOfTurnstileTableView.rightAnchor, paddingTop: -236, height: 280)
        addSubview(abdominalView)
        abdominalView.anchor(top: localBodyPlaceControl.bottomAnchor, left: bgView.leftAnchor, bottom: addButton.topAnchor, right: bgView.rightAnchor, paddingLeft: 20, paddingRight: 20)
    }
    private func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    @objc
    private func addButtonDidTap() {
        guard let turnstile = viewModel.getTurnstileForSave() else { return }
        delegate?.saveTourniquet(turnstile)
    }
    @objc
    private func dismissKeyboard() {
        endEditing(true)
    }
    @objc
    private func closeBottonDidTap() {
        delegate?.closeBottonDidTap()
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.bigSpecifyTheExactLocationView.alpha = 0
            self?.specifyTheExactLocationView.alpha = 0
        }
    }
    @objc
    private func segmentChanged(_ sender: UISegmentedControl) {
        guard let selectedSegment = BodyPlace(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        switch selectedSegment {
        case .limbs:
            viewModel.state = 0
        case .knotty:
            viewModel.state = 1
            typeOfTurnstileTableView.reloadData()
            nodalTypeOfTurnstileTableView.reloadData()
        case .abdominal:
            viewModel.state = 2
        }
    }
}

extension AddTourniquetView: PlaceOfOverlapViewDelegate {
    func getTitleOfSelect(_ title: Int) {
        viewModel.limb = title
    }
}
//TODO: - show or hide table view, typeOfTurnstileTableView
extension AddTourniquetView: TypeOfTurnstileViewDelegate {
    func getTypeOfTurnstile() {
        if nodalTypeOfTurnstileTableView.alpha == 1 {
            viewModel.isTypeOfTurnstileForLimbs = false
            viewModel.isTypeOfTurnstileForNodal = true
            DispatchQueue.main.async { [weak self] in
                self?.nodalTypeOfTurnstileTableView.alpha =  self?.nodalTypeOfTurnstileTableView.alpha == 0 ? 1 : 0
            }
        } else {
            viewModel.isTypeOfTurnstileForNodal = false
            viewModel.isTypeOfTurnstileForLimbs = true
            DispatchQueue.main.async { [weak self] in
                self?.typeOfTurnstileTableView.alpha = self?.typeOfTurnstileTableView.alpha == 0 ? 1 : 0
            }
        }
    }
}

extension AddTourniquetView: TypeOfTrainingViewDelegate {
    func getTime(_ time: String) {
        viewModel.time = time
    }
    func setMethod(_ method: PikerStage) {
        switch method {
        case .pikedOne:
            viewModel.overlayTypeTurnstile = "Швидкий"
            viewModel.method = 0
            specifyTheExactLocationView.alpha = 0
        case .pikedTwo:
            viewModel.overlayTypeTurnstile = "Прицільний"
            viewModel.method = 1
            specifyTheExactLocationView.alpha = 1
        }
    }
}

extension AddTourniquetView: UITableViewDelegate, UITableViewDataSource {
    private func configureTableView() {
        typeOfTurnstileTableView.delegate = self
        typeOfTurnstileTableView.dataSource = self
        nodalTypeOfTurnstileTableView.delegate = self
        nodalTypeOfTurnstileTableView.dataSource = self
        typeOfTurnstileTableView.register(TypeOfTrainingViewCell.self, forCellReuseIdentifier: TypeOfTrainingViewCell.identifier)
        nodalTypeOfTurnstileTableView.register(TypeOfTrainingViewCell.self, forCellReuseIdentifier: TypeOfTrainingViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isTypeOfTurnstileForNodal ? viewModel.typeOfTurnstileListForNodal.count : viewModel.typeOfTurnstileListForLimbs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TypeOfTrainingViewCell.identifier, for: indexPath) as! TypeOfTrainingViewCell

        let typeOfTurnstileString: String
        if viewModel.isTypeOfTurnstileForNodal {
            if indexPath.row < viewModel.typeOfTurnstileListForNodal.count {
                typeOfTurnstileString = viewModel.typeOfTurnstileListForNodal[indexPath.row]
            } else {
                // Handle the error, maybe return a default string or log an error
                return UITableViewCell() // Return an empty cell to avoid crash
            }
        } else {
            if indexPath.row < viewModel.typeOfTurnstileListForLimbs.count {
                typeOfTurnstileString = viewModel.typeOfTurnstileListForLimbs[indexPath.row]
            } else {
                // Handle the error, maybe return a default string or log an error
                return UITableViewCell() // Return an empty cell to avoid crash
            }
        }

        cell.setTitle(typeOfTurnstileString)
        cell.accessoryType = indexPath == viewModel.selectedIndex ? .checkmark : .none
        cell.tintColor = .black700
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getTypeOfTurnstile()
        let typeOfTurnstileString = viewModel.isTypeOfTurnstileForNodal ? viewModel.typeOfTurnstileListForNodal[indexPath.row] : viewModel.typeOfTurnstileListForLimbs[indexPath.row]
        
        viewModel.getIndex(indexPath)
        viewModel.selectedIndex = indexPath
        typeOfTurnstileView.setTitle(typeOfTurnstileString)
        nodalView.setupTypeLabel(typeOfTurnstileString)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// In your ViewModel
class ViewModel {
    var isTypeOfTurnstileForNodal: Bool = false
    var typeOfTurnstileListForNodal: [String] = []
    var typeOfTurnstileListForLimbs: [String] = []
    var selectedIndex: IndexPath?

    func getIndex(_ indexPath: IndexPath) {
        selectedIndex = indexPath
    }
}

extension AddTourniquetView: SpecifyTheExactLocationViewDelegate {
    func changeToBig() {
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.bigSpecifyTheExactLocationView.alpha = 1
            self?.specifyTheExactLocationView.alpha = 0
            self?.typeOfTrainingView.selectFirstButton()
        }
    }
}
extension AddTourniquetView: CustomSegmentedControlDelegate {
    func segmentControlDidChange(_tag: Int) {
        typeOfTurnstileTableView.alpha = 0
        abdominalView.dismissDropView()
        nodalTypeOfTurnstileTableView.alpha = 0
        nodalView.alpha = _tag == 1 ? 1 : 0
        abdominalView.alpha = _tag == 2 ? 1 : 0
        if _tag == 0 {
            placeOfOverlapView.updateSegmentedControl()
            viewModel.updateData()
            typeOfTrainingView.updateTime()
            typeOfTurnstileView.updateLabel()
            viewModel.state = 0
            typeOfTurnstileTableView.alpha = 0
        }
        if _tag == 1 {
            nodalView.updateData()
            viewModel.updateData()
            viewModel.isTypeOfTurnstileForNodal = true
            nodalTypeOfTurnstileTableView.reloadData()
            viewModel.state = 1
            nodalTypeOfTurnstileTableView.alpha = 0
        }
        if _tag == 2 {
            abdominalView.updateSegmentedControl()
            viewModel.updateData()
            viewModel.state = 2
        }
    }
}
extension AddTourniquetView: NodalViewDelegate {
    func update(_ time: String) {
        viewModel.time = time
    }
    
    func update(_ limb: Int) {
        viewModel.limb = limb
    }
    
    func update(viewModel: AddTourniquetViewViewModel) {
        self.viewModel = viewModel
        self.viewModel.isTypeOfTurnstileForNodal = nodalTypeOfTurnstileTableView.alpha == 0 ? false : true
        nodalTypeOfTurnstileTableView.alpha =  self.viewModel.isTypeOfTurnstileForNodal ? 0 : 1
    }
    
    func dismissTableView() {
        nodalTypeOfTurnstileTableView.alpha =  nodalTypeOfTurnstileTableView.alpha == 0 ? 1 : 0
        viewModel.isTypeOfTurnstileForNodal = nodalTypeOfTurnstileTableView.alpha == 0 ? false : true
    }
}


extension AddTourniquetView: AbdominalViewDelegate {
    func updateType(_ type: Int, state: Int) {
        viewModel.type = type
        viewModel.state = state
    }
    
    func typeTurnstile(_ turnstile: String) {
        viewModel.typeOfTurnstile = turnstile
    }
    
    func updateTime(_ time: String) {
        viewModel.time = time
    }
    
    func updateLimb(_ limb: Int) {
        viewModel.limb = limb
        
    }
}
