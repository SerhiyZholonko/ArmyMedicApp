//
//  InjuriesandTraumasInfoControllerViewController.swift
//  Dehealth
//
//  Created by apple on 23.02.2024.
//

import UIKit

class InjuriesandTraumasInfoViewController: UIViewController {
	 //MARK: - Properties
    private var viewModel = InjuriesandTraumasInfoViewControllerViewModel()
	private lazy var headerView: ProgressBarFirstView = {
		let view = ProgressBarFirstView()
		view.oneView.setupNumber(number: .nil)
        let oneColor = "#FFFFFF".hexColor().withAlphaComponent(0.1)
        view.oneView.backgroundColor = oneColor
		view.twoView.setupNumberColor(color: .black)
		view.twoView.setupBackgroundColor(color: .white)
        view.twoView.setupNumber(number: .two)
		view.delegate = self
		return view
	}()
	private lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.delegate = self
		cv.dataSource = self
		cv.backgroundColor = .clear
		return cv
	}()
	private let bottomView: BottomView = {
		let view = BottomView()
		return view
	}()
    private lazy var addPreliminaryDiagnosisView: AddNoteView = {
        let view = AddNoteView()
        view.setTitle("Попередній діагноз")
        view.delegate = self
        view.alpha = 0
        return view
    }()
    private lazy var addTourniquetView: AddTourniquetView = {
       let view = AddTourniquetView()
        view.delegate = self
        view.alpha = 0
        return view
    }()
	//MARK: - Livecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
        configureCollectionView()
		configureBottomView()
		configureHeader()
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.backgroundColor = .clear
	}
	 //MARK: - Functions
	private func configureHeader() {
		headerView.setupTitle(numberOfCart: "203 36 14")
	}
	private func configureBottomView() {
		bottomView.delegate = self
	}
    private func configureCollectionView() {
        collectionView.register(InjuriesAndTraumasCell.self, forCellWithReuseIdentifier: InjuriesAndTraumasCell.identifier)
        collectionView.register(TourniquetCell.self, forCellWithReuseIdentifier: TourniquetCell.identifier)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
    }
	private func configureUI() {
		view.backgroundColor = UIColor(named: "BGColor")

		// Initialize collection view layout
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical // Set scroll direction

		// Initialize collection view with layout
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)

//		// Register collection view cells

	
		
		// Add collection view to the view hierarchy
		view.addSubview(headerView)
		view.addSubview(bottomView)
		view.addSubview(collectionView)
		headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 108)
		bottomView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, height: 100)
		collectionView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: bottomView.topAnchor, right: view.rightAnchor)
		// Reload collection view data if needed
//		collectionView.reloadData()
        view.addSubview(addPreliminaryDiagnosisView)
        addPreliminaryDiagnosisView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        view.addSubview(addTourniquetView)
        addTourniquetView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
	}
}


 //MARK: - delegate

extension InjuriesandTraumasInfoViewController: ProgressBarFirstViewDelegate {
	func didTapBackButton() {
		navigationController?.popViewController(animated: true)
//		}
	}
}
func numberOfSections(in collectionView: UICollectionView) -> Int {
	return 1
}
extension InjuriesandTraumasInfoViewController: BottomViewDelegate {
	func moveToNextSection() {
        let vc = AssistanceProvidedController()
        navigationController?.pushViewController(vc, animated: true)
	}
	
	func moveToBackSection() {
		navigationController?.popViewController(animated: true)
	}
	
	
}

 //MARK: - CollectionView

extension InjuriesandTraumasInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if indexPath.section == 0 && indexPath.row == 0 {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InjuriesAndTraumasCell.identifier, for: indexPath) as! InjuriesAndTraumasCell
            cell.configureCell(viewModel: viewModel)
			cell.delegate = self
			return cell
		} else
        if indexPath.section == 0 && indexPath.row == 1 {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourniquetCell.identifier, for: indexPath) as! TourniquetCell
            cell.setTitle(title: "Турнікет")
            cell.updateViewModel(viewModel: viewModel)
            cell.delegate = self
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
			cell.setTitle(title: "Фото")
            cell.delegate = self
			return cell
		}
		
		
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if indexPath.section == 0 && indexPath.row == 0 {
            let height = viewModel.calculateHeight(width: collectionView.frame.width)
            return CGSize(width: collectionView.frame.width, height: 348 + (viewModel.isNotDiagnoseOrColorsOfMark ? 48 : height + 24) + CGFloat( viewModel.colorsSetListIsEmpty ? 0 : 50))
		} else if indexPath.section == 0 && indexPath.row == 1  {
            
            return CGSize(width: collectionView.frame.width, height: 64 + viewModel.tourniquetHeight) // Example size
        } else {
            return CGSize(width: collectionView.frame.width, height: 56)
        }
	}

}



 //MARK: - extension delegate

extension InjuriesandTraumasInfoViewController: InjuriesAndTraumasCellDelegate {
    func textWillChange(text: String) {
        viewModel.preliminaryDiagnosis = text
        addPreliminaryDiagnosisView.alpha = 1
    }
    func addDiagnose() {
        addPreliminaryDiagnosisView.alpha = 1
    }
    func reloadCollectionView() {
        collectionView.reloadData()
    }
	func openVCForAddInjuries() {
		let vc = InjuriesAndWoundsController()
		vc.modalPresentationStyle = .fullScreen
		present(vc, animated: true)
	}
}

extension InjuriesandTraumasInfoViewController: AddNoteViewDelegate {
    func addText(_ text: String) {
        viewModel.preliminaryDiagnosis = text
        addPreliminaryDiagnosisView.alpha =  0
        collectionView.reloadData()
    }
    
    func cancel() {
        viewModel.preliminaryDiagnosis = ""
        addPreliminaryDiagnosisView.alpha =  0
        collectionView.reloadData()
    }
    
    func close() {
        addPreliminaryDiagnosisView.alpha =  0
        view.endEditing(true)
    }
    
    
}

extension InjuriesandTraumasInfoViewController: TourniquetCellDelegate {
    func addItem() {
        addTourniquetView.alpha = 1

    }
    
    
}

extension InjuriesandTraumasInfoViewController: PhotoCellDelegate {
    func addButtonDidTap() {
        
    }
}
extension InjuriesandTraumasInfoViewController: AddTourniquetViewDelegate {
    func saveTourniquet(_ tourniquet: Tourniquet) {
        addTourniquetView.alpha = 0
        //TODO: - create tourniquet array
        viewModel.addNewTourniquet(tourniquet)
        collectionView.reloadData()
        
        
    }
    
    func closeBottonDidTap() {
        addTourniquetView.alpha = 0
    }
    
    
}
