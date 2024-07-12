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
}

class InjuriesAndTraumasCell: UICollectionViewCell {
    //MARK: - Properties
    weak var delegate: InjuriesAndTraumasCellDelegate?
    private var viewModel: InjuriesandTraumasInfoViewControllerViewModel?
    static let identifier = "InjuriesAndTraumasCell"
    private lazy var headerView: InjuriesAndTraumasCellHeader = {
        let view = InjuriesAndTraumasCellHeader()
        view.delegate = self
        return view
    }()
    private let manFrontImageView: UIImageView = {
        let image = UIImage(named: "manFront")
        let iv = UIImageView(image: image)
        iv.setWidth(154)
        iv.setHeight(280)
        return iv
    }()
    private let manBackImageView: UIImageView = {
        let image = UIImage(named: "manBack")
        let iv = UIImageView(image: image)
        iv.setWidth(154)
        iv.setHeight(280)
        return iv
    }()
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            manFrontImageView,
            manBackImageView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = -10
        return stackView
    }()
    private let spacerView: UIView = {
       let view = UIView()
        view.setWidth(20)
        return view
    }()
    private let colorView: AddColorView = {
        let view = AddColorView()
        return view
    }()
    private lazy var previousActView: PreviousActView = {
      let view = PreviousActView()
//        view.setHeight(32)
        view.delegate = self
        return view
    }()
    private lazy var preliminaryDiagnosisCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.alpha = 0
        return cv
    }()
	 //MARK: -
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
        configureCollectionView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: - Functions
    func configureCell(viewModel: InjuriesandTraumasInfoViewControllerViewModel) {
        self.viewModel = viewModel
        preliminaryDiagnosisCollectionView.alpha = viewModel.isNotDiagnoseOrColorsOfMark ? 0 : 1
        previousActView.alpha = viewModel.isNotDiagnoseOrColorsOfMark ? 1 : 0
        preliminaryDiagnosisCollectionView.reloadData()
    }
    private func configureCollectionView() {
        preliminaryDiagnosisCollectionView.register(PreliminaryDiagnosisCollectionViewCell.self, forCellWithReuseIdentifier: PreliminaryDiagnosisCollectionViewCell.identifier)
        preliminaryDiagnosisCollectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: ColorCollectionViewCell.identifier)
    }
	private func configureUI() {
		contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 16, paddingBottom: 8, paddingRight: 16)
		
		contentView.backgroundColor = .white
		addSubview(headerView)
		headerView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingRight: 16, height: 40)
		
		addSubview(imageStackView)
		imageStackView.anchor(top: headerView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingLeft: 28,paddingRight: 28,  width: 326, height: 280)
		contentView.layer.cornerRadius = 12
        addSubview(previousActView)
        previousActView.anchor(top: imageStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        addSubview(preliminaryDiagnosisCollectionView)
        preliminaryDiagnosisCollectionView.anchor(top: imageStackView.bottomAnchor,  left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
	}
	
}


 //MARK: - delegate
extension InjuriesAndTraumasCell: InjuriesAndTraumasCellHeaderDelegate {
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


extension InjuriesAndTraumasCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCollectionViewCell.identifier, for: indexPath) as! ColorCollectionViewCell
            return cell
        } else if indexPath.section == 0 && indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreliminaryDiagnosisCollectionViewCell.identifier, for: indexPath) as! PreliminaryDiagnosisCollectionViewCell
            if let viewModel = viewModel {
                cell.configureCell(viewModel: viewModel)
            }
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
     
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 && indexPath.row == 0, let viewModel = viewModel {
            if viewModel.isColorEmpty {
                return CGSize(width: frame.width - 32, height: 0)
            }
            return CGSize(width: frame.width - 32, height: 30)
        } else if indexPath.section == 0 && indexPath.row == 1, let viewModel = viewModel {
            let height: CGFloat = viewModel.calculateHeight(width: frame.width)

            return CGSize(width: frame.width - 32, height: height)
        }  else {
            return CGSize(width: frame.width - 32, height: 30)

        }
    }
}



extension InjuriesAndTraumasCell: PreliminaryDiagnosisCollectionViewCellDelegate {
    func changeDiagnose(_ text: String) {
        delegate?.textWillChange(text: text)
    }
    
    func addDiagnose() {
    
    }
    
    
}
