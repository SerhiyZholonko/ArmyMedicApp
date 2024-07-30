//
//  AssistanceProvidedController.swift
//  Dehealth
//
//  Created by apple on 29.05.2024.
//

import UIKit

class AssistanceProvidedController: UIViewController {
     //MARK: - Properties
    private var viewModel = AssistanceProvidedControllerViewModel()
    private lazy var headerView: ProgressBarFirstView = {
        let view = ProgressBarFirstView()
        view.oneView.setupNumber(number: .nil)
        let oneColor = "#FFFFFF".hexColor().withAlphaComponent(0.1)
        view.oneView.backgroundColor = oneColor
        view.twoView.setupNumber(number: .nil)
        view.twoView.backgroundColor = oneColor
        view.threeView.setupNumberColor(color: .black)
        view.threeView.setupBackgroundColor(color: .white)
        view.delegate = self
        return view
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .black200
        return cv
    }()
    private let bottomView: BottomView = {
        let view = BottomView()
        view.setTitleForLeftButton("Зберегти картку")
        view.setIsEnableRightButton(true)
        return view
    }()
    private lazy var addThePreparationView: AddThePreparationView = {
        let view = AddThePreparationView()
        view.delegate = self
        view.alpha = 0
        return view
    }()
    private lazy var bloodLossControlView: PikerListControlView = {
        let view = PikerListControlView(frame: .zero, height: 308, style: .blood)
        view.setTitle("Контроль крововтрати")
        view.setListArray(["Тиснуча повязка", "Гемостатичні засоби", "Конверсія", "Переливання крові"])
        view.delegate = self
        view.alpha = 0
        return view
    }()
    private lazy var devicesForBreathingRecoveryView: PikerListControlView = {
        let view = PikerListControlView(frame: .zero, height: 584, style: .breathing)
        view.setTitle("Пристрої для відновлення дихання")
        view.setListArray(["Інтактні", "Крікотіреотомія", "ЕТ трубка", "Назофарингеальний повітропровод", "Надгортанний повітропровод", "О2", "Голкова декомпресія", "Дренування", "Пов’язка", "Інше"])
        view.delegate = self
        view.alpha = 0

        return view
    }()
    private lazy var otherWorkView: PikerListControlView = {
        let view = PikerListControlView(frame: .zero, height: 348, style: .note)
        view.setTitle("Інша надана допомога:")
        view.setListArray(["Набір пігулок", "Шина", "Пов’язка на ліве око", "Пов’язка на праве око", "Тип попередження гіпотермії"])
        view.delegate = self
        view.alpha = 0
        return view
    }()
    private lazy var addNoteView: AddNoteView = {
        let view = AddNoteView()
        view.delegate = self
        return view
    }()
     //MARK: - livecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        configureCollectionView()
        //*configureViewModel()
    }
    
     //MARK: - Functions

    private func configureCollectionView() {
        collectionView.register(AssistanceProvidedCell.self, forCellWithReuseIdentifier: AssistanceProvidedCell.identifier)
        collectionView.register(SignsAndSymptomsCell.self, forCellWithReuseIdentifier: SignsAndSymptomsCell.identifier)
        collectionView.register(EvacuationConditionOfTheWoundedCell.self, forCellWithReuseIdentifier: EvacuationConditionOfTheWoundedCell.identifier)
    }
    private func configureUI() {
        view.addSubview(headerView)
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 100)
        view.addSubview(bottomView)
        bottomView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, height: 100)
        view.addSubview(collectionView)
        collectionView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: bottomView.topAnchor, right: view.rightAnchor)
        view.addSubview(addThePreparationView)
        addThePreparationView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        view.addSubview(bloodLossControlView)
        bloodLossControlView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        view.addSubview(devicesForBreathingRecoveryView)
        devicesForBreathingRecoveryView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        view.addSubview(otherWorkView)
        otherWorkView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        view.addSubview(addNoteView)
        addNoteView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}
extension AssistanceProvidedController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 && indexPath.row == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AssistanceProvidedCell.identifier, for: indexPath) as! AssistanceProvidedCell
            cell.configureCell(viewModel: viewModel)
            cell.delegate = self
            return cell
        } else if indexPath.section == 0 && indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignsAndSymptomsCell.identifier, for: indexPath) as! SignsAndSymptomsCell
            return cell
        }else if indexPath.section == 0 && indexPath.row == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EvacuationConditionOfTheWoundedCell.identifier, for: indexPath) as! EvacuationConditionOfTheWoundedCell
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 && indexPath.row == 0{
            let noteHeight = viewModel.calculateHeight(width: view.frame.width)
            return CGSize(width: view.frame.width, height: 490 + viewModel.medicineHeight + noteHeight)
                          //+ 136 + 120)
        } else  if indexPath.section == 0 && indexPath.row == 1 {
            return CGSize(width: view.frame.width, height: 86 + 156 + 16)
        } else {
            return CGSize(width: view.frame.width, height: 440)
        }
    }

}
extension AssistanceProvidedController: ProgressBarFirstViewDelegate {
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension AssistanceProvidedController: AddThePreparationViewDelegate {
    func getNewPreparation(_ medicine: Medicine) {
        viewModel.addNewMedicine(medicine)
        addThePreparationView.alpha = addThePreparationView.alpha == 0 ? 1 : 0
        view.endEditing(true)
        collectionView.reloadData()
    }
    
    func closeButtonDidTap() {
        addThePreparationView.alpha = addThePreparationView.alpha == 0 ? 1 : 0
        view.endEditing(true)
    }
}

extension AssistanceProvidedController: AssistanceProvidedCellProtocol {
    func addNote() {
        addNoteView.alpha = 1
    }
    
    func reloadCell() {
        collectionView.reloadData()
    }
    
    func notes() {
        otherWorkView.alpha = otherWorkView.alpha == 0 ? 1 : 0
    }
    
    func devicesForBreathing() {
        devicesForBreathingRecoveryView.alpha = devicesForBreathingRecoveryView.alpha == 0 ? 1 : 0
    }
    func bloodLossControl() {
        //TODO: -
        bloodLossControlView.alpha = bloodLossControlView.alpha == 0 ? 1 : 0
    }
    func medicinesAndDrugsButtonDidTap() {
        addThePreparationView.nameDrugTextFieldFirsResponder()
        addThePreparationView.alpha = addThePreparationView.alpha == 0 ? 1 : 0

    }
}

extension AssistanceProvidedController: PikerListControlViewDelegate {
    func saveBloodControlButtonDidTap(titles: [String]) {
        bloodLossControlView.alpha = 0
        viewModel.bloodLossControlString = titles.joined(separator: ", ")
        collectionView.reloadData()
    }
    func saveBreathingButtonDidTap(titles: [String]) {
        devicesForBreathingRecoveryView.alpha = 0
        viewModel.briefingControlString = titles.joined(separator: ", ")
        collectionView.reloadData()
    }
    func saveNoteButtonDidTap(titles: [String]) {
        otherWorkView.alpha = 0
        viewModel.otherWorkString = titles.joined(separator: ", ")
        collectionView.reloadData()
    }
}

extension AssistanceProvidedController: AddNoteViewDelegate {
    func addText(_ text: String) {

        viewModel.noteControlString = text
        addNoteView.alpha = 0
        view.endEditing(true)
        let noteHeight = viewModel.calculateHeight(width: view.frame.width)
        collectionView.reloadData()
    }
    
    func cancel() {
        viewModel.noteControlString = ""
        addNoteView.alpha = 0
        view.endEditing(true)
        collectionView.reloadData()
    }
    
    func close() {
        addNoteView.alpha = 0
        view.endEditing(true)
    }
}
