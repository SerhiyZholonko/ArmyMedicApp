//
//  MainInfoControllerView.swift
//  Dehealth
//
//  Created by apple on 08.02.2024.
//

import UIKit

class MainInfoControllerViewController: UIViewController {
    private var selectedImage: UIImage? {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Properties
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBlue
        return cv
    }()
    private lazy var headerView: ProgressBarFirstView = {
        let view = ProgressBarFirstView()
        view.oneView.setupNumber(number: .one)
        view.twoView.setupNumber(number: .two)
        view.delegate = self
        return view
    }()
    private lazy var bottomView: BottomView = {
        let view = BottomView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        registerForKeyboardNotifications()
    }

    deinit {
        unregisterForKeyboardNotifications()
    }
    
    // MARK: - Functions
    private func configureUI() {
        view.backgroundColor = UIColor(named: "BGColor")

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(MainInfoCell.self, forCellWithReuseIdentifier: MainInfoCell.identifier)
        collectionView.register(AxialIdentificationCell.self, forCellWithReuseIdentifier: AxialIdentificationCell.identifier)
        collectionView.register(PlaceOfCombatOperationsCell.self, forCellWithReuseIdentifier: PlaceOfCombatOperationsCell.identifier)
        collectionView.register(EvacuationCell.self, forCellWithReuseIdentifier: EvacuationCell.identifier)
        collectionView.register(ProgressBarFirstView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProgressBarFirstViewHeader")

        view.addSubview(headerView)
        view.addSubview(bottomView)
        view.addSubview(collectionView)
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 108)
        bottomView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, height: 100)
        collectionView.anchor(top: headerView.bottomAnchor, left: view.leftAnchor, bottom: bottomView.topAnchor, right: view.rightAnchor)
        collectionView.reloadData()
        configureCollectionView()
    }

    private func configureCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 40, right: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
           let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
            let keyboardHeight = keyboardFrame.height
            UIView.animate(withDuration: animationDuration) {
                self.collectionView.contentInset.bottom = keyboardHeight
                self.collectionView.scrollIndicatorInsets.bottom = keyboardHeight
            }
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        if let userInfo = notification.userInfo,
           let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
            UIView.animate(withDuration: animationDuration) {
                self.collectionView.contentInset.bottom = 0
                self.collectionView.scrollIndicatorInsets.bottom = 0
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainInfoControllerViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainInfoCell.identifier, for: indexPath) as! MainInfoCell
            cell.configure(with: selectedImage)
            cell.delegate = self
            cell.layer.cornerRadius = 12
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AxialIdentificationCell.identifier, for: indexPath) as! AxialIdentificationCell
            cell.delegate = self
            cell.layer.cornerRadius = 12
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceOfCombatOperationsCell.identifier, for: indexPath) as! PlaceOfCombatOperationsCell
            cell.layer.cornerRadius = 12
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainInfoControllerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth = min(collectionView.bounds.width, 358)
        if indexPath.row == 0 {
            let height: CGFloat = 656
            return CGSize(width: maxWidth, height: height)
        }
        if indexPath.row == 1 {
            let height: CGFloat = 288
            return CGSize(width: maxWidth, height: height)
        }
        if indexPath.row == 2 {
            let height: CGFloat = 238
            return CGSize(width: maxWidth, height: height)
        }
        let height: CGFloat = 0
        return CGSize(width: maxWidth, height: height)
    }
}
extension MainInfoControllerViewController:  UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
              // Handle the selected image
              print("Image selected: \(selectedImage)")
              // For example, you can assign the image to an UIImageView
              // imageView.image = selectedImage
              self.selectedImage = selectedImage
          }
          dismiss(animated: true, completion: nil)
      }
      
      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          dismiss(animated: true, completion: nil)
      }
}
extension MainInfoControllerViewController: MainInfoCellDelegate{
    func showImagePiker() {
        let imagePickerController = UIImagePickerController()
               imagePickerController.delegate = self
               imagePickerController.sourceType = .photoLibrary // or .camera for taking a new photo
               present(imagePickerController, animated: true, completion: nil)
    }
    
    func setGender(_ gender: Gender) {
        switch gender {
        case .man:
            print("Man")
        case .woman:
            print("Woman")
        }
    }

    func markDidTap() {
        print("Mark image view tapped!")
        collectionView.reloadData()
    }
}

extension MainInfoControllerViewController: ProgressBarFirstViewDelegate {
    func didTapBackButton() {
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension MainInfoControllerViewController: BottomViewDelegate {
    func moveToBackSection() {
    }

    func moveToNextSection() {
        let vc = InjuriesandTraumasInfoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: - delegate cell

extension MainInfoControllerViewController: AxialIdentificationCellDelegate {
    func showDropBox() {
        print("Main VC..")
        //TODO: - show some piker
    }
    
    
}

#Preview() {
    MainInfoControllerViewController()
}
