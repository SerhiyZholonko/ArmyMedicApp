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
    func getInjuriesAndTraumasModel(model: InjuriesAndTraumasModel)
    func deleteItemFromColorList(model: InjuriesAndTraumasModel)
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
        iv.contentMode = .scaleAspectFit
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
//        SetInjuryImageOnManFrontImageView()
        if viewModel.isHeadImageOnFront {
            SetHeadImageOnManFrontImageView()
//            addMiniMark1(at: CGPointMake(185.66665649414062 / 1.9, 103.33332824707031*0.6), imageName: "fragmentary")
        }
        updateInjuryMarks()

        collectionView.reloadData()
    }
    func updateCollectionView() {
        collectionView.reloadData()
    }
    private func updateInjuryMarks() {
        // Clear existing marks on the image view
        clearAllMarks()

        // Ensure viewModel and woundList are available
        guard let viewModel = viewModel, !viewModel.woundList.isEmpty else { return }

        // Iterate through each wound and place marks on the image view
        viewModel.woundList.forEach { wound in
            let point = CGPoint(x: CGFloat(wound.x) / 1.9, y: CGFloat(wound.y) * 0.6)
            let imageName: String
            
            switch wound.weaponType {
            case 1:
                imageName = "fragmentary"
            case 2:
                imageName = "balloon"
            case 3:
                imageName = "mine:IED"
            case 6:
                imageName = "amputation"
            default:
                return
            }

            if wound.isOnBackSide {
                addMiniMark2(at: point, imageName: imageName)
            } else {
                addMiniMark1(at: point, imageName: imageName)
            }
        }
    }
    private func clearAllMarks() {
        // Assuming 'imageView' is the UIImageView where marks are drawn
        manFrontImageView.subviews.forEach { $0.removeFromSuperview() }
        manBackImageView.subviews.forEach { $0.removeFromSuperview() }

    }
    private func SetInjuryImageOnManFrontImageView() {
        guard let viewModel = viewModel, !viewModel.woundList.isEmpty else { return }
        //viewModel.woundList.e
        viewModel.woundList.forEach { wound in
            switch wound.weaponType {
            case 1:
                if !wound.isOnBackSide {
                    addMiniMark1(at: CGPointMake(CGFloat(wound.x) / 1.9, CGFloat(wound.y)*0.6), imageName: "fragmentary")
                } else {
                    addMiniMark2(at: CGPointMake(CGFloat(wound.x) / 1.9, CGFloat(wound.y)*0.6), imageName: "fragmentary")
                }
                
            case 2:
                if !wound.isOnBackSide {
                    addMiniMark1(at: CGPointMake(CGFloat(wound.x) / 1.9, CGFloat(wound.y)*0.6), imageName: "balloon")
                } else {
                    addMiniMark2(at: CGPointMake(CGFloat(wound.x) / 1.9, CGFloat(wound.y)*0.6), imageName: "balloon")
                }
                
            case 3:
                if !wound.isOnBackSide {
                    addMiniMark1(at: CGPointMake(CGFloat(wound.x) / 1.9, CGFloat(wound.y)*0.6), imageName: "mine:IED")
                } else {
                    addMiniMark2(at: CGPointMake(CGFloat(wound.x) / 1.9, CGFloat(wound.y)*0.6), imageName: "mine:IED")
                }
            case 6:
                if !wound.isOnBackSide {
                    addMiniMark1(at: CGPointMake(CGFloat(wound.x) / 1.9, CGFloat(wound.y)*0.6), imageName: "amputation")
                } else {
                    addMiniMark2(at: CGPointMake(CGFloat(wound.x) / 1.9, CGFloat(wound.y)*0.6), imageName: "amputation")
                }
            default:
                break
            }
        }
    }
    private func SetHeadImageOnManFrontImageView() {
        addMiniMark1(at: CGPointMake(128.3333282470703 / 1.9, 22.666656494140625*0.6), imageName: "headInjury")
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
            cell.delegate = self
            if let viewModel = viewModel {
                cell.configureCell(viewModel: viewModel)
            }
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
            return CGSize(width: frame.width - 32, height: viewModel!.markedInjuriesandTraumasList.isEmpty ? 1 : 80)
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
                return CGSize(width: frame.width, height: 20)
            }
            return CGSize.zero
        }
        return CGSize.zero
    }
    private func addMiniMarkForInjury(at location: CGPoint, imageName: String) {
        let width = manFrontImageView.frame.width
        let miniImageView = UIImageView(image: UIImage(named: imageName))
        miniImageView.translatesAutoresizingMaskIntoConstraints = false
        miniImageView.widthAnchor.constraint(equalToConstant: width > 200 ? 40 : 20).isActive = true
        miniImageView.heightAnchor.constraint(equalToConstant: width > 200 ? 40 : 20).isActive = true
        manFrontImageView.addSubview(miniImageView)
        
        
        let addWidth = ((manFrontImageView.frame.width - 126.0) / 2) - 5
        // Directly use the location without converting it to a percentage
        NSLayoutConstraint.activate([
            miniImageView.centerXAnchor.constraint(equalTo: manFrontImageView.leftAnchor, constant: location.x + addWidth),
            miniImageView.centerYAnchor.constraint(equalTo: manFrontImageView.topAnchor, constant: location.y)
        ])
    }
    private func addMiniMark1(at location: CGPoint, imageName: String) {
        let width = manFrontImageView.frame.width
        let miniImageView = UIImageView(image: UIImage(named: imageName))
        miniImageView.translatesAutoresizingMaskIntoConstraints = false
        miniImageView.widthAnchor.constraint(equalToConstant: width > 200 ? 40 : 20).isActive = true
        miniImageView.heightAnchor.constraint(equalToConstant: width > 200 ? 40 : 20).isActive = true
        manFrontImageView.addSubview(miniImageView)
        let addWidth = ((manFrontImageView.frame.width - 126.0) / 2) - 5
        // Directly use the location without converting it to a percentage
        NSLayoutConstraint.activate([
            miniImageView.centerXAnchor.constraint(equalTo: manFrontImageView.leftAnchor, constant: location.x + addWidth),
            miniImageView.centerYAnchor.constraint(equalTo: manFrontImageView.topAnchor, constant: location.y)
        ])
    }
    private func addMiniMark2(at location: CGPoint, imageName: String) {
        let width = manBackImageView.frame.width
        let miniImageView = UIImageView(image: UIImage(named: imageName))
        miniImageView.translatesAutoresizingMaskIntoConstraints = false
        miniImageView.widthAnchor.constraint(equalToConstant: width > 200 ? 40 : 20).isActive = true
        miniImageView.heightAnchor.constraint(equalToConstant: width > 200 ? 40 : 20).isActive = true
        manFrontImageView.addSubview(miniImageView)
        let addWidth = ((manBackImageView.frame.width - 126.0) / 2) - 5
        // Directly use the location without converting it to a percentage
        NSLayoutConstraint.activate([
            miniImageView.centerXAnchor.constraint(equalTo: manBackImageView.leftAnchor, constant: location.x + addWidth),
            miniImageView.centerYAnchor.constraint(equalTo: manBackImageView.topAnchor, constant: location.y)
        ])
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


extension InjuriesAndTraumasCell : ColorCollectionViewCellDelegate {
    func deleteItem(item: InjuriesAndTraumasModel) {
        delegate?.deleteItemFromColorList(model: item)
    }
    
    func getInjuriesAndTraumasModel(model: InjuriesAndTraumasModel) {
        delegate?.getInjuriesAndTraumasModel(model: model)
    }
}
