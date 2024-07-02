//
//  AssistanceProvidedCell.swift
//  Dehealth
//
//  Created by apple on 29.05.2024.
//

import UIKit

protocol AssistanceProvidedCellProtocol: AnyObject {
    func medicinesAndDrugsButtonDidTap()
    func bloodLossControl()
    func devicesForBreathing()
    func notes()
    func addNote()
    func reloadCell()
}

class AssistanceProvidedCell: UICollectionViewCell {
     //MARK: - Properties
    var viewModel: AssistanceProvidedControllerViewModel?
    private var height: CGFloat = 0
    weak var delegate: AssistanceProvidedCellProtocol?
    static let identifier = "AssistanceProvidedCell"
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Надана допомога"
        label.font = .interBold(size: 18)
        return label
    }()
    private let bloodLosLabel: UILabel = {
       let label = UILabel()
        label.text = "Контроль крововтрати"
        label.font = .interLight(size: 14)
        return label
    }()
    private lazy var bloodLoseView: DropdownSelectionView = {
        let view = DropdownSelectionView()
        view.delegate = self
        return view
    }()
    private let devicesForBreathingRecoveryLabel: UILabel = {
       let label = UILabel()
        label.text = "Пристрої для відновлення дихання"
        label.font = .interLight(size: 14)
        return label
    }()
    private lazy var devicesForBreathingRecoveryView: DropdownSelectionView = {
        let view = DropdownSelectionView(frame: .zero)
        view.currentAction = .devicesForBreathing
        view.delegate = self
        return view
    }()
    private let otherHelpLabel: UILabel = {
       let label = UILabel()
        label.text = "Інша допомога"
        label.font = .interLight(size: 14)
        return label
    }()
    private lazy var otherHelpView: DropdownSelectionView = {
        let view = DropdownSelectionView()
        view.currentAction = .note
        view.delegate = self
        return view
    }()
    
    private lazy var medicinesAndDrugsLabel = CustomLabel(textLabel: "Ліки та препарати", textColorLabel: .black, fontLabel: .interMedium(size: 18))
    private lazy var medicinesAndDrugsCollectionView: MedicinesAndDrugsCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = MedicinesAndDrugsCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    private var medicinesAndDrugsCollectionViewHeightConstraint: NSLayoutConstraint?
    
    private lazy var medicinesAndDrugsButton = CustomButton( image: UIImage(named: "plus"), customFont: .interMedium(size: 14))
    private lazy var notesLabel = CustomLabel(textLabel: "Нотатки", textColorLabel: .black, fontLabel: .interMedium(size: 18))
    private lazy var notesButton = CustomButton( image: UIImage(named: "plus"), customFont: .interMedium(size: 14))
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
     //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButtons()
        configureUI()
        medicinesAndDrugsCollectionView.register(MedicinesAndDrugsCollectionViewCell.self, forCellWithReuseIdentifier: MedicinesAndDrugsCollectionViewCell.identifier)
        notesCollectionView.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: NoteCollectionViewCell.identifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    func configureCell(viewModel: AssistanceProvidedControllerViewModel) {
        bloodLoseView.setupTitle(viewModel.bloodLossControlString)
        devicesForBreathingRecoveryView.setupTitle(viewModel.briefingControlString)
        otherHelpView.setupTitle(viewModel.otherWorkString)
        
        // Update the height for medicinesAndDrugsCollectionView
        height = viewModel.medicineHeight
        medicinesAndDrugsCollectionViewHeightConstraint?.constant = height
        self.viewModel = viewModel
        medicinesAndDrugsCollectionView.reloadData()
        notesCollectionView.reloadData()
//        delegate?.reloadCell()
    }
    private func configureUI() {
        backgroundColor = .black200
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 16, paddingBottom: 10, paddingRight: 16)
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 16, paddingLeft: 16)
        addSubview(bloodLosLabel)
        bloodLosLabel.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, paddingTop: 16, height: 24)
        addSubview(bloodLoseView)
        bloodLoseView.anchor(top: bloodLosLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 4, paddingLeft: 16, paddingRight: 16, height: 48)
        addSubview(devicesForBreathingRecoveryLabel)
        devicesForBreathingRecoveryLabel.anchor(top: bloodLoseView.bottomAnchor, left: bloodLoseView.leftAnchor, right: bloodLoseView.rightAnchor, paddingTop: 24, height: 24)
        addSubview(devicesForBreathingRecoveryView)
        devicesForBreathingRecoveryView.anchor(top: devicesForBreathingRecoveryLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 4, paddingLeft: 16, paddingRight: 16, height: 48)
        addSubview(otherHelpLabel)
        otherHelpLabel.anchor(top: devicesForBreathingRecoveryView.bottomAnchor, left: devicesForBreathingRecoveryView.leftAnchor, right: devicesForBreathingRecoveryView.rightAnchor, paddingTop: 24, height: 24)
        addSubview(otherHelpView)
        otherHelpView.anchor(top: otherHelpLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 4, paddingLeft: 16, paddingRight: 16, height: 48)
        addSubview(medicinesAndDrugsLabel)
        medicinesAndDrugsLabel.anchor(top: otherHelpView.bottomAnchor, left: otherHelpView.leftAnchor, paddingTop: 24, height: 32)
        addSubview(medicinesAndDrugsButton)
        medicinesAndDrugsButton.anchor(top: otherHelpView.bottomAnchor, right: otherHelpView.rightAnchor, paddingTop: 24, height: 32)
        addSubview(medicinesAndDrugsCollectionView)
        medicinesAndDrugsCollectionView.anchor(top: medicinesAndDrugsLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor)
        medicinesAndDrugsCollectionViewHeightConstraint = medicinesAndDrugsCollectionView.heightAnchor.constraint(equalToConstant: height)
        medicinesAndDrugsCollectionViewHeightConstraint?.isActive = true
        
        //TODO: -
        addSubview(notesLabel)
        notesLabel.anchor(top: medicinesAndDrugsCollectionView.bottomAnchor, left: otherHelpView.leftAnchor, paddingTop: 28, height: 32)
        addSubview(notesButton)
        notesButton.anchor(top: medicinesAndDrugsCollectionView.bottomAnchor, right: otherHelpView.rightAnchor, paddingTop: 28, height: 32)
        addSubview(notesCollectionView)
        notesCollectionView.anchor(top: notesLabel.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, height: 120)
        //TODO: - height for note view
    }
    private func configureButtons() {
        medicinesAndDrugsButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        notesButton.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        medicinesAndDrugsButton.addTarget(self, action: #selector(medicinesAndDrugsButtonDidTap), for: .touchUpInside)
        notesButton.addTarget(self, action: #selector(notesButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    private func medicinesAndDrugsButtonDidTap() {
        print("medicinesAndDrugsButton did tap")
        delegate?.medicinesAndDrugsButtonDidTap()
    }
    @objc
    private func notesButtonDidTap() {
        print("notesButton did tap")
        delegate?.addNote()
    }
}


//
//#Preview() {
//    AssistanceProvidedController()
//}


extension AssistanceProvidedCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == medicinesAndDrugsCollectionView {
            return viewModel?.medicineCount ?? 0
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == medicinesAndDrugsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicinesAndDrugsCollectionViewCell.identifier, for: indexPath) as! MedicinesAndDrugsCollectionViewCell
            if let viewModel = self.viewModel {
                cell.configureCell(model: viewModel.medicines[indexPath.row])
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCollectionViewCell.identifier, for: indexPath) as! NoteCollectionViewCell
            cell.delegate = self
            if let viewModel =  viewModel {
                cell.configure(with: viewModel.noteControlString)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == medicinesAndDrugsCollectionView {
            return CGSize(width: collectionView.frame.width, height: 68)
        } else if collectionView == notesCollectionView {
            if let viewModel = viewModel {
                let text = viewModel.noteControlString
                 let width = collectionView.frame.width - 32 // Subtract padding
               let height = NoteCollectionViewCell.calculateHeight(for: text, width: width)
                 return CGSize(width: width, height: height)
            } else {
                return CGSize(width: collectionView.frame.width, height: 0)
            }
        } else  {
            return CGSize(width: collectionView.frame.width, height: 110)
        }
    }
    
}


extension AssistanceProvidedCell: DropdownSelectionViewDelegate {
    func noteShowDropBox() {
        delegate?.notes()
    }
    
    func bloodLoseShowDropBox() {
        delegate?.bloodLossControl()

    }
 
    
    func devicesForBreathingShowDropBox() {
        delegate?.devicesForBreathing()
    }
}


//Delegate cell

extension AssistanceProvidedCell: NoteCollectionViewCellDelegate {
    func updateText(string: String, cell: NoteCollectionViewCell) {
        viewModel?.noteControlString = string
        notesCollectionView.reloadData()

        //        if let noteString = viewModel?.noteControlString {
        //            let concatenatedString = noteString + string
        //            // Use concatenatedString as needed
        //            viewModel!.noteControlString = concatenatedString
        //                    notesCollectionView.reloadData()
        //
        //        } else {
        //            // Handle the case where viewModel?.noteControlString is nil
        //        }
        ////        DispatchQueue.main.async {
        ////            cell.makeTextViewFirstResponder()
        ////        }
        //    }
    }
    
}


