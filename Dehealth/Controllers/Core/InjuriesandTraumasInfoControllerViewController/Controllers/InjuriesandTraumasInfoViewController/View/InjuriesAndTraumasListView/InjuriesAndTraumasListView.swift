//
//  InjuriesAndTraumasListView.swift
//  Dehealth
//
//  Created by apple on 22.07.2024.
//



import UIKit

protocol InjuriesAndTraumasListViewDelegate: AnyObject {
    func presentVCForAddInjuries(_ model: InjuriesAndTraumasModel)
    func setCustomSubviewAlpha(to alpha: CGFloat, model: InjuriesAndTraumasModel)
}

class InjuriesAndTraumasListView: UIView {
    // MARK: - Properties
    
    weak var delegate: InjuriesAndTraumasListViewDelegate?
    private var viewModel: InjuriesAndTraumasListViewModel
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black150
        cv.layer.cornerRadius = 12
        return cv
    }()
    
    // MARK: - Init
     init(frame: CGRect, viewModel: InjuriesAndTraumasListViewModel) {
         self.viewModel = viewModel
        super.init(frame: frame)
        configureUI()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    private func configureUI() {
        backgroundColor = .white
        layer.cornerRadius = 12
        addShadow()
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    private func addShadow() {
        layer.shadowColor = UIColor(red: 0.4, green: 0.42, blue: 0.5, alpha: 1.0).cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 24
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(InjuriesAndTraumasListCell.self, forCellWithReuseIdentifier: InjuriesAndTraumasListCell.identifier)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension InjuriesAndTraumasListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getSizeInjuriesAndTraumasList()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InjuriesAndTraumasListCell.identifier, for: indexPath) as! InjuriesAndTraumasListCell
        if let model = viewModel.getItem(by: indexPath) {
            cell.configureCell(model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.injuriesAndTraumasList[indexPath.item]
        switch model.typeOfTransition {
        case .withSection:
            
            delegate?.setCustomSubviewAlpha(to: 1, model: model)
        case .burns:
           // delegate?.presentVCForAddInjuries(model)
            print("burns")
//            break
        case .headInjury:
            delegate?.setCustomSubviewAlpha(to: 1, model: model)
        case .marksWithTheHelpOfGesture:
            delegate?.presentVCForAddInjuries(model)
        case .none:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1 // Spacing between rows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1 // Spacing between items in the same row (if applicable)
    }
}
