//
//  GroinPlaceOfOverlapView.swift
//  Dehealth
//
//  Created by apple on 12.07.2024.
//

import UIKit

protocol GroinPlaceOfOverlapViewDelegate: AnyObject {
    func getTitleOfSelect(_ title: Int)
}

class GroinPlaceOfOverlapView: UIView {
    // MARK: - Properties
    weak var delegate: GroinPlaceOfOverlapViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Пахова область *"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let dividerTopView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let dividerBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var handsSegmentedControl: UISegmentedControl = {
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
        return sc
    }()
    
    private lazy var legsSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: GroinLeftAndRightSegment.allCases.map { $0.title })
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
        return sc
    }()
    
    // MARK: - Enums
    
    enum GroinLeftOrRightSegment: Int, CaseIterable {
        case left, right
        
        var title: String {
            switch self {
            case .left: return "Ліва"
            case .right: return "Права"
            }
        }
    }
    
    enum GroinLeftAndRightSegment: Int, CaseIterable {
        case leftRight
        
        var title: String {
            switch self {
            case .leftRight: return "Ліва та права"
            }
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func updateSegmentedControl() {
        legsSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        handsSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
    }

    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, height: 24)
        addSubview(handsSegmentedControl)
        handsSegmentedControl.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, right: rightAnchor, paddingTop: 8, height: 48)
        addSubview(dividerTopView)
        dividerTopView.anchor(top: handsSegmentedControl.topAnchor, bottom: handsSegmentedControl.bottomAnchor, width: 1)
        dividerTopView.centerX(inView: handsSegmentedControl)
        addSubview(legsSegmentedControl)
        legsSegmentedControl.anchor(top: handsSegmentedControl.bottomAnchor, left: handsSegmentedControl.leftAnchor, right: handsSegmentedControl.rightAnchor, paddingTop: 8, height: 48)
      
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        if sender == handsSegmentedControl {
            legsSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        } else if sender == legsSegmentedControl {
            handsSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        }
        if let title = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            if title == "Ліва" {
                delegate?.getTitleOfSelect(0)
            } else if title == "Права" {
                delegate?.getTitleOfSelect(1)
            } else if title == "Ліва Права" {
                delegate?.getTitleOfSelect(2)
            }
        }
    }
}
