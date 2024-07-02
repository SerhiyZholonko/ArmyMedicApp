//
//  InjuriesandTraumasInfoControllerViewController.swift
//  Dehealth
//
//  Created by apple on 23.02.2024.
//

import UIKit

class InjuriesandTraumasInfoViewController: UIViewController {
	 //MARK: - Properties
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
		cv.backgroundColor = .systemBlue
		return cv
	}()
	private let bottomView: BottomView = {
		let view = BottomView()
		return view
	}()

	//MARK: - Livecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
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
	private func configureUI() {
		view.backgroundColor = UIColor(named: "BGColor")

		// Initialize collection view layout
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical // Set scroll direction

		// Initialize collection view with layout
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)

//		// Register collection view cells

		collectionView.register(InjuriesAndTraumasCell.self, forCellWithReuseIdentifier: InjuriesAndTraumasCell.identifier)
		collectionView.register(TourniquetCell.self, forCellWithReuseIdentifier: TourniquetCell.identifier)
		
		// Add collection view to the view hierarchy
		view.addSubview(headerView)
		view.addSubview(bottomView)
		view.addSubview(collectionView)
		headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 108)
		bottomView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, height: 100)
		collectionView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: bottomView.topAnchor, right: view.rightAnchor)
		// Reload collection view data if needed
//		collectionView.reloadData()
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
	// Return the number of sections in the collection view
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
			cell.delegate = self
			return cell
		} else if indexPath.section == 0 && indexPath.row == 1 {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourniquetCell.identifier, for: indexPath) as! TourniquetCell
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourniquetCell.identifier, for: indexPath) as! TourniquetCell
			cell.setTitle(title: "Фото та відео")
			return cell
		}
		
		
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		// Adjust the size according to your needs
		if indexPath.section == 0 && indexPath.row == 0 {
			return CGSize(width: collectionView.frame.width, height: 396) // Example size

		} else {
			return CGSize(width: collectionView.frame.width, height: 64) // Example size
		}
	}

}



 //MARK: - extension delegate

extension InjuriesandTraumasInfoViewController: InjuriesAndTraumasCellDelegate {
	func openVCForAddInjuries() {
		
		let vc = InjuriesAndWoundsController()
		vc.modalPresentationStyle = .fullScreen
		present(vc, animated: true)
	}
	
	
}




#Preview() {
    InjuriesandTraumasInfoViewController()
}
