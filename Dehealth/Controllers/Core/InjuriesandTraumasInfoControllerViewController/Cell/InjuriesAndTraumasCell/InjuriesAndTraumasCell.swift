//
//  InjuriesAndTraumasCell.swift
//  Dehealth
//
//  Created by apple on 23.02.2024.
//



import UIKit

protocol InjuriesAndTraumasCellDelegate: AnyObject {
    func openVCForAddInjuries()
    func reloadCollectionView()
    func addDiagnose()
    func textWillChange(text: String)
    func showInjuryList(on cell: InjuriesAndTraumasCell)
}

class InjuriesAndTraumasCell: UICollectionViewCell {
    // MARK: - Properties
    weak var delegate: InjuriesAndTraumasCellDelegate?
    private var viewModel: InjuriesandTraumasInfoViewControllerViewModel?
    static let identifier = "InjuriesAndTraumasCell"
    
    private lazy var headerView: InjuriesAndTraumasCellHeader = {
        let view = InjuriesAndTraumasCellHeader()
        view.delegate = self
        return view
    }()
    
    private let manFrontImageView: UIImageView = {
        let image = UIImage(named: "body front")
        let iv = UIImageView(image: image)
        iv.setWidth(125.77)
        iv.setHeight(280)
        return iv
    }()
    
    private let manBackImageView: UIImageView = {
        let image = UIImage(named: "body back")
        let iv = UIImageView(image: image)
        iv.setWidth(125.77)
        iv.setHeight(280)
        return iv
    }()
    
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [manFrontImageView, manBackImageView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 40
        return stackView
    }()
    
    private lazy var spacerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.setWidth(view.frame.width)
        view.isHidden = true // Initially hidden
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: frame.width - 32, height: 40) // Set the header size
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        return cv
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func configureCell(viewModel: InjuriesandTraumasInfoViewControllerViewModel) {
        headerView.isInjuryListView = false
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
    private func configureCollectionView() {
        collectionView.register(PreliminaryDiagnosisCollectionViewCell.self, forCellWithReuseIdentifier: PreliminaryDiagnosisCollectionViewCell.identifier)
        collectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.identifier)
        collectionView.register(PreviousActView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PreviousActView.identifier)
    }
    
    private func configureUI() {
        contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 16, paddingBottom: 8, paddingRight: 16)
        contentView.backgroundColor = .white
        addSubview(imageStackView)
        addSubview(collectionView)
        addSubview(headerView)
        imageStackView.anchor(top: headerView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 20, paddingLeft: 28, paddingRight: 28, width: 326, height: 280)
        contentView.layer.cornerRadius = 12
        headerView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingRight: 16, height: 40)
        collectionView.anchor(top: imageStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20)
    }
}

// MARK: - Delegate
extension InjuriesAndTraumasCell: InjuriesAndTraumasCellHeaderDelegate {
    func showInjuryList() {
        delegate?.showInjuryList(on: self)
    }
    
    func openVCForAddInjuries() {
        delegate?.openVCForAddInjuries()
    }
}

extension InjuriesAndTraumasCell: PreviousActViewDelegate {
    func plusImageViewDidTap() {
        delegate?.addDiagnose()
        delegate?.reloadCollectionView()
    }
}

extension InjuriesAndTraumasCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return viewModel!.markedInjuriesandTraumasList.isEmpty ? 0 : 1
        case 1:
            return 1
        default:
           return 1
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.identifier, for: indexPath) as! ColorCollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreliminaryDiagnosisCollectionViewCell.identifier, for: indexPath) as! PreliminaryDiagnosisCollectionViewCell
            if let viewModel = viewModel {
                cell.configureCell(viewModel: viewModel)
            }
            cell.delegate = self
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            //TODO: - height
            return CGSize(width: frame.width - 32, height: viewModel!.markedInjuriesandTraumasList.isEmpty ? 1 : 70)
        } else {
            if let viewModel = viewModel, viewModel.preliminaryDiagnosis != "" {
                let height: CGFloat = viewModel.calculateHeight(width: frame.width)
                return CGSize(width: frame.width - 32, height: height)
            } else {
                return CGSize(width: frame.width - 32, height: 0)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 1 {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PreviousActView.identifier, for: indexPath) as! PreviousActView
                header.delegate = self
                return header
            }
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            if let viewModel = viewModel, viewModel.preliminaryDiagnosis.isEmpty {
                return CGSize(width: frame.width, height: 40)
            }
            return CGSize.zero
        }
        return CGSize.zero
    }
}

extension InjuriesAndTraumasCell: PreliminaryDiagnosisCollectionViewCellDelegate {
    func changeDiagnose(_ text: String) {
        delegate?.textWillChange(text: text)
    }

    func addDiagnose() {
        delegate?.addDiagnose()
        collectionView.reloadData()
    }
}
