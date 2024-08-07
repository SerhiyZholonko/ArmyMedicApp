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

		// Add collection view to the view hierarchy
		view.addSubview(headerView)
		view.addSubview(bottomView)
		view.addSubview(collectionView)
		headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 108)
		bottomView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, height: 100)
		collectionView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: bottomView.topAnchor, right: view.rightAnchor)
		// Reload collection view data if needed
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
            return CGSize(width: collectionView.frame.width, height: 348 + (viewModel.isNotDiagnose ? 48 : height + 24) + 40 + (viewModel.colorsSetListIsEmpty ? 0 : 70))
		} else if indexPath.section == 0 && indexPath.row == 1  {
            return CGSize(width: collectionView.frame.width, height: 56 + viewModel.tourniquetHeight) // Example size
        } else {
            return CGSize(width: collectionView.frame.width, height: 56)
        }
	}

}
//MARK: - Add InjuriesandTraumas list view
 //MARK: - extension delegate

//MARK: - Remove item from color view

extension InjuriesandTraumasInfoViewController: InjuriesAndTraumasCellDelegate, UIGestureRecognizerDelegate {
    func deleteItemFromColorList(model: InjuriesAndTraumasModel) {
       //TODO: - Remove item from color view
        viewModel.deleteItemFromColorList(model: model)
        
        collectionView.reloadData()
    }
   
    func getInjuriesAndTraumasModel(model: InjuriesAndTraumasModel) {
        let vc = SetWoundingController()
        vc.delegate = self
        vc.setupModel(model, woundList: viewModel.woundList)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func showInjuryList(on cell: InjuriesAndTraumasCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }

        let cellFrame = collectionView.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
        let cellFrameInSuperview = collectionView.convert(cellFrame, to: collectionView.superview)

        let overlayView = UIView(frame: view.bounds)
        overlayView.tag = 999
        
        let injuriesAndTraumasListView = InjuriesAndTraumasListView(frame: .zero, viewModel: InjuriesAndTraumasListViewModel(selectedInjuriesAndTraumasList: viewModel.markedInjuriesandTraumasList))
        injuriesAndTraumasListView.delegate = self // Set delegate here
        overlayView.addSubview(injuriesAndTraumasListView)
        //TODO: - extra view
        let injuriesAndTraumasListDetailView = InjuriesAndTraumasListDetailView()
        injuriesAndTraumasListDetailView.delegate = self
        overlayView.addSubview(injuriesAndTraumasListDetailView) // Add subCustomView to customSubview
        
        injuriesAndTraumasListView.translatesAutoresizingMaskIntoConstraints = false
        injuriesAndTraumasListDetailView.translatesAutoresizingMaskIntoConstraints = false

        let height = viewModel.calculateHeight(width: collectionView.frame.width)
        let adjustedTopConstant = cellFrameInSuperview.maxY - (325 + height + 40 - (viewModel.isNotDiagnose ? 40 : 25) - (viewModel.isColorEmpty ? 0 : -65))
        //for cells that are used
        let sizeUsedCell = viewModel.markedInjuriesandTraumasList.count * 48
        NSLayoutConstraint.activate([
            injuriesAndTraumasListView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: cellFrameInSuperview.minX - 32),
            injuriesAndTraumasListView.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: adjustedTopConstant),
            injuriesAndTraumasListView.heightAnchor.constraint(equalToConstant: CGFloat(384 - sizeUsedCell)),
            injuriesAndTraumasListView.widthAnchor.constraint(equalToConstant: 220),
            
            injuriesAndTraumasListDetailView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: cellFrameInSuperview.minX - 32),
            injuriesAndTraumasListDetailView.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: adjustedTopConstant),
            injuriesAndTraumasListDetailView.widthAnchor.constraint(equalToConstant: 220),
            injuriesAndTraumasListDetailView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeOverlay(_:)))
        tapGesture.delegate = self
        overlayView.addGestureRecognizer(tapGesture)

        view.addSubview(overlayView)
    }

    @objc private func removeOverlay(_ sender: UITapGestureRecognizer) {
        guard let overlayView = sender.view else { return }
        let location = sender.location(in: overlayView)
        if let customSubview = overlayView.subviews.first(where: { $0 is InjuriesAndTraumasListView }) {
                if customSubview.alpha == 1 {
                    overlayView.removeFromSuperview()
                    collectionView.reloadData()
                } else if !customSubview.frame.contains(location) {
                    customSubview.alpha = 0
                    collectionView.reloadData()
                }
        }
    }
       // UIGestureRecognizerDelegate method
       func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
           if let view = gestureRecognizer.view, let customSubview = view.subviews.first(where: { $0 is InjuriesAndTraumasListView }) {
               let location = touch.location(in: customSubview)
               return !customSubview.bounds.contains(location)
           }
           if let view = gestureRecognizer.view, let customSubview = view.subviews.last(where: { $0 is InjuriesAndTraumasListDetailView }) {
               let location = touch.location(in: customSubview)
               return !customSubview.bounds.contains(location)
           }
           return true
       }


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

//TODO: - now
extension InjuriesandTraumasInfoViewController: InjuriesAndTraumasListViewDelegate {
    func setCustomSubviewAlpha(to alpha: CGFloat, model: InjuriesAndTraumasModel) {
        if let overlayView = view.viewWithTag(999),
           let customSubview = overlayView.subviews.first(where: { $0 is InjuriesAndTraumasListView }),
           let subCustomView = overlayView.subviews.last(where: { $0 is InjuriesAndTraumasListDetailView }) as? InjuriesAndTraumasListDetailView {
           
            UIView.animate(withDuration: 0.2) { [weak self] in
                switch model.typeOfTransition {
                    
                case .withSection:
                    if model.imageName == .poisoning {
                        let viewModel = InjuriesAndTraumasListDetailViewModel(type: .poisoning)
                        subCustomView.updateViewModel(viewModel: viewModel) // Correctly calling the method
                        subCustomView.alpha = 1
                        customSubview.alpha = 0
                    } else {
                        let viewModel = InjuriesAndTraumasListDetailViewModel(type: .percussion)
                        subCustomView.updateViewModel(viewModel: viewModel) // Correctly calling the method
                        subCustomView.alpha = 1
                        customSubview.alpha = 0
                    }
                case .burns:
                    break
                case .headInjury:
                    if let overlayView = self?.view.viewWithTag(999),
                       let customSubview = overlayView.subviews.first(where: { $0 is InjuriesAndTraumasListView }){
                            UIView.animate(withDuration: 0.2) {
                                customSubview.alpha = 0
                                overlayView.removeFromSuperview()
                        }
                    }
                    let item = InjuriesAndTraumasModel(whatPicture: .front, imageName: .headInjury, title: "Травма голови", typeOfTransition: .headInjury)
                    self?.viewModel.markedInjuriesandTraumasList.append(item)
                    self?.viewModel.isHeadImageOnFront = true
                    self?.collectionView.reloadData()
                case .marksWithTheHelpOfGesture:
                   
                    subCustomView.alpha = 1
                    customSubview.alpha = 0
                case .none:
                    break
                }
            }
        }
    }
    
    func presentVCForAddInjuries(_ model: InjuriesAndTraumasModel) {
        if let overlayView = view.viewWithTag(999) {
            overlayView.removeFromSuperview()
        }
        //TODO: - update for all title
        collectionView.reloadData()
        let vc = SetWoundingController()
        vc.delegate = self
        vc.setupModel(model, woundList: viewModel.woundList)
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
    func didTapEditButton(on cell: PlaceOnBodyCollectionViewCell, at cellFrameInSuperview: CGRect) {
        showOverlay(at: cellFrameInSuperview)
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

extension InjuriesandTraumasInfoViewController {
    func showOverlay(at cellFrameInSuperview: CGRect) {
        let overlayView = UIView(frame: view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.tag = 998
        let customSubview = EditView()
        overlayView.addSubview(customSubview)
        customSubview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customSubview.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: cellFrameInSuperview.minX - 40),
            customSubview.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: cellFrameInSuperview.maxY - 60),
            customSubview.heightAnchor.constraint(equalToConstant: 83),
            customSubview.widthAnchor.constraint(equalToConstant: 200)
        ])
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissOverlay(_:)))
        overlayView.addGestureRecognizer(tapGesture)
        view.addSubview(overlayView)
    }
    @objc
    private func dismissOverlay(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
}



extension InjuriesandTraumasInfoViewController: InjuriesAndTraumasListDetailViewDelegate {
    func backButtonDidTap() {
        if let overlayView = view.viewWithTag(999),
           let customSubview = overlayView.subviews.first(where: { $0 is InjuriesAndTraumasListView }),
           let subCustomView = overlayView.subviews.last(where: { $0 is InjuriesAndTraumasListDetailView }) as? InjuriesAndTraumasListDetailView {
            UIView.animate(withDuration: 0.2) {
                let viewModel = InjuriesAndTraumasListDetailViewModel(type: .percussion)
                subCustomView.updateViewModel(viewModel: viewModel) // Correctly calling the method
                subCustomView.alpha = 0
                UIView.animate(withDuration: 0.2) {
                    customSubview.alpha = 1
                }
            }
        }
    }
}



extension InjuriesandTraumasInfoViewController: SetWoundingControllerDelegate {
    func getWoundList(woundList: [Wound], model: SetWoundingControllerViewModel) {
        for wound in woundList {
            if !self.viewModel.woundList.contains(wound) {
                self.viewModel.woundList.append(wound)
                }
        }
        
        let item = InjuriesAndTraumasModel(whatPicture: model.isOnBackSide ? .back : .front, imageName: model.imageName!, title: model.imageName!.title , typeOfTransition: .marksWithTheHelpOfGesture)
        viewModel.addNewItemInmarkedInjuriesandTraumasList(item: item)
        collectionView.reloadData()

    }
}



