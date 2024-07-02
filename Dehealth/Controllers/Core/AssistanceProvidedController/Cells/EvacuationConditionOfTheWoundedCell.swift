//
//  EvacuationConditionOfTheWoundedCell.swift
//  Dehealth
//
//  Created by apple on 03.06.2024.
//



import UIKit
protocol EvacuationConditionOfTheWoundedCellDelegate: AnyObject {
    func setGender(_ gender: Gender)
}
class EvacuationConditionOfTheWoundedCell: UICollectionViewCell {
    
    
    //MARK: - Properties
    
    static let identifier = "EvacuationConditionOfTheWoundedCell"
    
    weak var delegate: EvacuationConditionOfTheWoundedCellDelegate?
    private let evacuationLabel: UILabel = {
       let label = UILabel()
        label.font = .interBold(size: 18)
        label.text = "Евакуація"
        return label
    }()
    private let ConditionOfTheWoundedLabel: UILabel = {
       let label = UILabel()
        label.font = .interLight(size: 14)
        label.text = "Стан пораненого"
        return label
    }()
    private let fioLabel: PaddedLabel = {
       let label = PaddedLabel()
        label.text = "Шевченко Денис Юрійович"
        label.backgroundColor = .black100
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.layer.borderColor = UIColor.black200!.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    private lazy var prioritySegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["ЗЕЛЕНИЙ", "ЖОВТИЙ", "ЧЕРВОНИЙ", "ЗАГИБЛИЙ"])
//          sc.selectedSegmentIndex = 0
          sc.backgroundColor = .white
       
          sc.tintColor = .blue 
        sc.selectedSegmentTintColor = .Status500
        //"#5E42EC".hexColor()
          let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
          sc.setTitleTextAttributes(titleTextAttributes, for: .selected)
          let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
          sc.setTitleTextAttributes(normalTextAttributes, for: .normal)
        sc.setHeight(48)
        // Configure text font size
        let font = UIFont.interMedium(size: 12) // Change the size as needed
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white
        ]
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]

        sc.setTitleTextAttributes(normalAttributes, for: .normal)
        sc.setTitleTextAttributes(selectedAttributes, for: .selected)

          sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
          return sc
      }()
    private let destinationLabel: UILabel = {
       let label = UILabel()
        label.font = .interLight(size: 14)
        label.text = "Місце призначення"
        return label
    }()
    private lazy var destinationView: DropdownSelectionView = {
        let view = DropdownSelectionView()
//        view.delegate = self
        return view
    }()
    private lazy var genderView: GenderView = {
        let view = GenderView()
        view.setTitles(titlePosition: "Положення", titleSitting: "Сидячи", titleLyingDown: "Лежачи")
        view.setPadding10(true)
        view.delegate = self
        return view
    }()
    private let responsibleMedicalOfficerLabel: UILabel = {
       let label = UILabel()
        label.font = .interLight(size: 14)
        label.text = "Відповідальний медик"
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
    private func configureUI() {
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .white
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 1, paddingLeft: 16, paddingBottom: 20, paddingRight: 16)
        
        addSubview(evacuationLabel)
        evacuationLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingTop: 20, paddingLeft: 20, height: 24)
        
        addSubview(ConditionOfTheWoundedLabel)
        ConditionOfTheWoundedLabel.anchor(top: evacuationLabel.bottomAnchor, left: evacuationLabel.leftAnchor, paddingTop: 16, height: 24)
        
        addSubview(prioritySegmentedControl)
        prioritySegmentedControl.anchor(top: ConditionOfTheWoundedLabel.bottomAnchor, left: ConditionOfTheWoundedLabel.leftAnchor, right: contentView.rightAnchor, paddingTop: 4, paddingRight: 8, height: 48)
        addSubview(destinationLabel)
        destinationLabel.anchor(top: prioritySegmentedControl.bottomAnchor, left: prioritySegmentedControl.leftAnchor, paddingTop: 24, height: 24)
        addSubview(destinationView)
        destinationView.anchor(top: destinationLabel.bottomAnchor, left: destinationLabel.leftAnchor, right: contentView.rightAnchor, paddingTop: 4, paddingRight: 20, height: 48)
        addSubview(genderView)
        genderView.anchor(top: destinationView.bottomAnchor, left: destinationView.leftAnchor, right: contentView.rightAnchor, paddingTop: 24, paddingRight: 20, height: 48)
        
        addSubview(responsibleMedicalOfficerLabel)
        responsibleMedicalOfficerLabel.anchor(top: genderView.bottomAnchor, left: genderView.leftAnchor, right: genderView.rightAnchor, paddingTop: 24, height: 24)
        addSubview(fioLabel)
        fioLabel.anchor(top: responsibleMedicalOfficerLabel.bottomAnchor, left: responsibleMedicalOfficerLabel.leftAnchor, right: responsibleMedicalOfficerLabel.rightAnchor, paddingTop: 4,height: 48)
    }
    
    @objc private func segmentChanged() {
        if prioritySegmentedControl.selectedSegmentIndex == 0 {
            prioritySegmentedControl.selectedSegmentTintColor = .Status500
        }
        if prioritySegmentedControl.selectedSegmentIndex == 1 {
            prioritySegmentedControl.selectedSegmentTintColor = "#FBC400".hexColor()
        }
        if prioritySegmentedControl.selectedSegmentIndex == 2 {
            prioritySegmentedControl.selectedSegmentTintColor = .red300
        }
        if prioritySegmentedControl.selectedSegmentIndex == 3 {
            prioritySegmentedControl.selectedSegmentTintColor = .black700
        }
       }
}
extension EvacuationConditionOfTheWoundedCell: GenderViewDelegate {
    func setGender(_ gender: Gender) {
        delegate?.setGender(gender)
    }
}
#Preview() {
    AssistanceProvidedController()
}

