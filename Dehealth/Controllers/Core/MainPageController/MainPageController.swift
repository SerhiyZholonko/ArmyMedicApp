//
//  MainPageController.swift
//  Dehealth
//
//  Created by apple on 25.12.2023.
//
import UIKit
//import FirebaseAuth

final class MainPageController: UIViewController {
	 //MARK: -Properties
	private var viewModel: MainPageControllerViewModelPro!
    private var isSearch: Bool = false {
        didSet {
            searchController.view.alpha = isSearch ? 1 : 0
        }
    }
	private lazy var isShowUserInfo: Bool = true {
		didSet {
			userView.isHidden = isShowUserInfo
		}
	}
	private lazy var headerView: HeaderMainView = {
		let view = HeaderMainView()
		view.delegate = self
		return view
	}()
	private lazy var userView: UserView = {
		let view = UserView()
		view.isHidden = true
		view.delegate = self
		return view
	}()
	private lazy var searchView: SearchByIdView = {
		let view = SearchByIdView()
		view.delegate = self
		view.setHeight(160)
		return view
	}()
	private let orLabel: UILabel = {
		let label = UILabel()
		label.text = "Або"
		label.font = .interExtraLight(size: 12)
		label.setHeight(16)
		return label
	}()
	private let emptyCartView: EmptyCartView = {
		let view = EmptyCartView()
		return view
	}()
	private lazy var createCart: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Створити картку пораненого", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = .interLight(size: 16)
		button.backgroundColor = "#FFFFFF".hexColor()
		button.layer.cornerRadius = 8
		button.layer.borderColor = "#8B92AC".hexColor().cgColor
		button.layer.borderWidth = 1
		// Add horizontal padding
		button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)

		button.addTarget(self, action: #selector(createCartDidTap), for: .touchUpInside)
		return button
	}()
	private let collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.backgroundColor = .secondarySystemBackground
		return collectionView
	}()

	private lazy var searchController: SearchViewController = {
        let viewModel = SearchViewControllerViewModel()
		let vc = SearchViewController(viewModel: viewModel)
		vc.delegate = self
		vc.view.alpha = 0
		return vc
	}()
	 //MARK: - Livecyccle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewModel()
		configureUI()
		configureCollectionView()
		addGesture()
		configureNavigationBar()
	}
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.endEditing(true)
    }
 //MARK: - Functions
	private func addGesture() {
		let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissUferInfoView))
		view.addGestureRecognizer(gesture)
	}
	private func configureViewModel() {
		viewModel = MainPageControllerViewModel()
	}
	private func configureUI() {
        view.backgroundColor = .black150
		view.addSubview(headerView)
		view.addSubview(userView)
		view.addSubview(searchView)
		view.addSubview(orLabel)
		view.addSubview(createCart)
		view.addSubview(emptyCartView)
		view.addSubview(collectionView)
		headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 64)
		userView.anchor(top: headerView.bottomAnchor, right: view.rightAnchor, paddingTop: 5, paddingRight: 20, width: 240, height: 112)
		searchView.centerY(inView: view)
		searchView.anchor( left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)

		orLabel.centerX(inView: view)
		orLabel.anchor(top: searchView.bottomAnchor, paddingTop: 16 )

		createCart.centerX(inView: view)
		createCart.anchor(top: orLabel.bottomAnchor, paddingTop: 16 )

		emptyCartView.anchor( left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 16, paddingBottom: 24, paddingRight: 16, height: 96)

		collectionView.anchor(top: emptyCartView.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: -30)
		//Search

		view.addSubview(searchController.view)
		searchController.view.anchor(top: headerView.bottomAnchor, left: headerView.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
	}
	private func configureNavigationBar() {
		// Hide the back button
		   self.navigationItem.leftBarButtonItem = nil
		   self.navigationItem.hidesBackButton = true
	}
	private func moveSearchViewController() {
        isSearch = true
        let _ = isSearch ? searchController.searchTextField.becomeFirstResponder() : searchController.searchTextField.resignFirstResponder()
		searchController.view.alpha = isSearch ? 1 : 0
	}
	private func configureCollectionView() {
		collectionView.register(SearchCell.self, forCellWithReuseIdentifier: SearchCell.identifier)
		collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.isHidden = viewModel.isSoldierEmpty
	}
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! CollectionHeaderView
			headerView.titleLabel.text = "Останні картки"
			headerView.titleLabel.font = .interMedium(size: 16)
			// Customize headerView further if needed
			return headerView
		}
		fatalError("Unexpected kind")
	}
	@objc func dismissUferInfoView() {
		isShowUserInfo = true
	}
	@objc
	private func createCartDidTap() {
		let vc = MainInfoControllerViewController()
		let navVC = UINavigationController(rootViewController: vc)
		navVC.modalPresentationStyle = .fullScreen
		present(navVC, animated: true)
	}
}


 //MARK: - delegate 
extension MainPageController: SearchByIdViewDelegate {
	func searchDidTouch() {
		moveSearchViewController()
	}
}
extension MainPageController: HeaderMainViewDelegate {
	func getUserInfo() {
		isShowUserInfo.toggle()
	}
}
extension MainPageController: UserViewDelegate {
	func makeSynhronyze() {
		
	}
	func goToExit() {
		viewModel.singOut()
	}
}
extension MainPageController: SearchViewControllerProtocol {
	func closeDidTouch() {
//		moveSearchViewController()
        isSearch = false
	}
}


 //MARK: - collection view

extension MainPageController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return .init(width: collectionView.frame.width, height: 56)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 50) // Adjust the height as needed
	}

}



