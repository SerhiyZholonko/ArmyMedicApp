//
//  SetWoundingController.swift
//  Dehealth
//
//  Created by apple on 28.02.2024.
//

import SwiftUI

protocol SetWoundingControllerDelegate: AnyObject {
    func getWoundList(woundList: [Wound], model: SetWoundingControllerViewModel)
}

class SetWoundingController: UIViewController {
    // MARK: - Properties
    weak var delegate: SetWoundingControllerDelegate?
    private var viewModel = SetWoundingControllerViewModel()

    private let mainImage1 = UIImage(named: "body front")
    private let mainImage2 = UIImage(named: "body back")
    private let mainImageView1 = UIImageView()
    private let mainImageView2 = UIImageView()
    private var miniImageViews1 = [UIImageView]() {
        didSet {
            //update bottom view
            bottomView.setIsEnableRightButton(miniImageViews1.isEmpty)

        }
    }
    private var miniImageViews2 = [UIImageView](){
        didSet {
            //update bottom view
            bottomView.setIsEnableRightButton(miniImageViews2.isEmpty)

        }
    }
    private var miniMarksLocations1 = [CGPoint]()
    private var miniMarksLocations2 = [CGPoint]()
    private var isActiveMiniImageViews1: Bool = true
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Позначте на схемі"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "xmark2"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        return button
    }()
    
        private let imageSubTitleLabel: ImageTitleView = {
           let view = ImageTitleView()
            return view
        }()
    
        private lazy var forwardBackwardView: TwoButtonView = {
         let view = TwoButtonView()
            view.delegate = self
            return view
        }()
    
        private lazy var bottomView: BottomView = {
            let view = BottomView()
            view.setTitleForRightButton("Очистити")
            view.setTitleForLeftButton("Зберегти")
            view.setIsEnableRightButton(viewModel.woundList.isEmpty)
            view.delegate = self
            return view
        }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addScrollView()
        configureViewModel()
        bottomView.setIsEnableRightButton(viewModel.woundList.isEmpty)

    }
    // MARK: - Functions

    private func backButtonIsActive() -> Bool {
        var isActive: Bool = false
        guard  !miniImageViews1.isEmpty || !miniImageViews2.isEmpty else { return isActive}
        isActive.toggle()
        return isActive
    }
    func backDidActive() {
        forwardBackwardView.backButtonIsActive(isActive: backButtonIsActive())
    }
    func setupModel(_ model: InjuriesAndTraumasModel, woundList: [Wound]) {
         imageSubTitleLabel.setTitle(model) // Uncomment if needed
        viewModel.image1Name = model.imageName.rawValue
        viewModel.imageName = model.imageName
        viewModel.woundList = woundList
        viewModel.woundList.forEach { wound in
            switch wound.weaponType {
                case 1:
                    if !wound.isOnBackSide {
                        addMiniMark1(at: CGPointMake(CGFloat(wound.x), CGFloat(wound.y)), imageName: "fragmentary")
                    } else {
                        addMiniMark2(at: CGPointMake(CGFloat(wound.x), CGFloat(wound.y)), imageName: "fragmentary")
                    }
                    
                case 2:
                    if !wound.isOnBackSide {
                        addMiniMark1(at: CGPointMake(CGFloat(wound.x), CGFloat(wound.y)), imageName: "balloon")
                    } else {
                        addMiniMark2(at: CGPointMake(CGFloat(wound.x), CGFloat(wound.y)), imageName: "balloon")
                    }
                    
                case 3:
                    if !wound.isOnBackSide {
                        addMiniMark1(at: CGPointMake(CGFloat(wound.x), CGFloat(wound.y)), imageName: "mine:IED")
                    } else {
                        addMiniMark2(at: CGPointMake(CGFloat(wound.x), CGFloat(wound.y)), imageName: "mine:IED")
                    }
                case 6:
                    if !wound.isOnBackSide {
                        addMiniMark1(at: CGPointMake(CGFloat(wound.x), CGFloat(wound.y)), imageName: "amputation")
                    } else {
                        addMiniMark2(at: CGPointMake(CGFloat(wound.x), CGFloat(wound.y)), imageName: "amputation")
                    }
                default:
                    break
                }
        }
    }
    private func addMiniMark1(at location: CGPoint, imageName: String) {
let width = mainImageView1.frame.width
        let miniImageView = UIImageView(image: UIImage(named: imageName))
        miniImageView.translatesAutoresizingMaskIntoConstraints = false
        miniImageView.widthAnchor.constraint(equalToConstant: width > 200 ? 40 : 40).isActive = true
        miniImageView.heightAnchor.constraint(equalToConstant: width > 200 ? 40 : 40).isActive = true
        mainImageView1.addSubview(miniImageView)
        
        
        let addWidth = ((mainImageView1.frame.width)) - 5
        // Directly use the location without converting it to a percentage
        NSLayoutConstraint.activate([
            miniImageView.centerXAnchor.constraint(equalTo: mainImageView1.leftAnchor, constant: location.x + addWidth),
            miniImageView.centerYAnchor.constraint(equalTo: mainImageView1.topAnchor, constant: location.y)
        ])
    }
    private func addMiniMark2(at location: CGPoint, imageName: String) {
        let width = mainImageView2.frame.width
        let miniImageView = UIImageView(image: UIImage(named: imageName))
        miniImageView.translatesAutoresizingMaskIntoConstraints = false
        miniImageView.widthAnchor.constraint(equalToConstant: width > 200 ? 40 : 40).isActive = true
        miniImageView.heightAnchor.constraint(equalToConstant: width > 200 ? 40 : 40).isActive = true
        mainImageView2.addSubview(miniImageView)
        
        
        let addWidth = ((mainImageView2.frame.width)) - 5
        // Directly use the location without converting it to a percentage
        NSLayoutConstraint.activate([
            miniImageView.centerXAnchor.constraint(equalTo: mainImageView2.leftAnchor, constant: location.x + addWidth),
            miniImageView.centerYAnchor.constraint(equalTo: mainImageView2.topAnchor, constant: location.y)
        ])
    }
    private func configureViewModel() {
        viewModel.delegate = self
    }
   
      
    private func addScrollView() {
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: imageSubTitleLabel.bottomAnchor, constant: 12),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            scrollView.bottomAnchor.constraint(equalTo: forwardBackwardView.topAnchor, constant: -12),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        guard let image1 = mainImage1, let image2 = mainImage2 else {
            return
        }
        
        mainImageView1.image = image1
        mainImageView2.image = image2
        mainImageView1.backgroundColor = .white
        mainImageView2.backgroundColor = .white
        mainImageView1.isUserInteractionEnabled = true
        mainImageView2.isUserInteractionEnabled = true
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped1(_:)))
        mainImageView1.addGestureRecognizer(tapGesture1)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(_:)))
        mainImageView2.addGestureRecognizer(tapGesture2)
        
        scrollView.addSubview(mainImageView1)
        scrollView.addSubview(mainImageView2)
        
        let imageViewWidth: CGFloat = 253
        let imageViewHeight: CGFloat = 458
        mainImageView1.layer.cornerRadius = 8
        mainImageView2.layer.cornerRadius = 8
        mainImageView1.translatesAutoresizingMaskIntoConstraints = false
        mainImageView2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainImageView1.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainImageView1.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            mainImageView1.widthAnchor.constraint(equalToConstant: imageViewWidth),
            mainImageView1.heightAnchor.constraint(equalToConstant: imageViewHeight),
            
            mainImageView2.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainImageView2.leftAnchor.constraint(equalTo: mainImageView1.rightAnchor, constant: 10),
            mainImageView2.widthAnchor.constraint(equalToConstant: imageViewWidth),
            mainImageView2.heightAnchor.constraint(equalToConstant: imageViewHeight)
        ])
        
        scrollView.contentSize = CGSize(width: imageViewWidth * 2 + 10, height: imageViewHeight)

    }
    
    private func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(dismissButton)
        view.addSubview(titleLabel)
        view.addSubview(imageSubTitleLabel)
        view.addSubview(forwardBackwardView)
        view.addSubview(bottomView)
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        forwardBackwardView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dismissButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -17),
            dismissButton.widthAnchor.constraint(equalToConstant: 18),
            dismissButton.heightAnchor.constraint(equalToConstant: 18),
            dismissButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 48),
            
            imageSubTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            imageSubTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            imageSubTitleLabel.widthAnchor.constraint(equalToConstant: 200),
            imageSubTitleLabel.heightAnchor.constraint(equalToConstant: 24),
            
            forwardBackwardView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            forwardBackwardView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -19),
            forwardBackwardView.widthAnchor.constraint(equalToConstant: 88),
            forwardBackwardView.heightAnchor.constraint(equalToConstant: 32),
            
            bottomView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            bottomView.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    private func addMiniMark1(at location: CGPoint) {
        let miniImageView = UIImageView(image: UIImage(named: viewModel.image1Name))
        miniImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        miniImageView.center = location
        mainImageView1.addSubview(miniImageView)
        miniImageViews1.append(miniImageView)
        miniMarksLocations1.append(location)
        //bottomView.setIsEnableRightButton(false)
        backDidActive()
        isActiveMiniImageViews1 = true
    }
    
    private func addMiniMark2(at location: CGPoint) {
        let miniImageView = UIImageView(image: UIImage(named: viewModel.image1Name))
        miniImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        miniImageView.center = location
        mainImageView2.addSubview(miniImageView)
        miniImageViews2.append(miniImageView)
        miniMarksLocations2.append(location)
       // bottomView.setIsEnableRightButton(false)
        backDidActive()
        isActiveMiniImageViews1 = false
    }
    @objc
    private func imageTapped1(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: mainImageView1)
        addMiniMark1(at: location)
    }
    
    @objc
    private func imageTapped2(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: mainImageView2)
        addMiniMark2(at: location)
    }
    @objc
    private func cancelButtonTapped() {
        for miniImageView in miniImageViews1 {
            miniImageView.removeFromSuperview()
        }
        for miniImageView in miniImageViews2 {
            miniImageView.removeFromSuperview()
        }
        miniImageViews1.removeAll()
        miniImageViews2.removeAll()
        miniMarksLocations1.removeAll()
        miniMarksLocations2.removeAll()

    }
    
    @objc
    private func saveButtonTapped() {
        miniMarksLocations1.forEach { miniMarksLocations in
            viewModel.isOnBackSide = false
            viewModel.x = Int(miniMarksLocations.x)
            viewModel.y = Int(miniMarksLocations.y)
            if  let wound: Wound = viewModel.getWound() {
                viewModel.addItemToWoundList(wound)
            }
        }
        miniMarksLocations2.forEach { miniMarksLocations in
            viewModel.isOnBackSide = true
            viewModel.x = Int(miniMarksLocations.x)
            viewModel.y = Int(miniMarksLocations.y)
            if  let wound: Wound = viewModel.getWound() {
                viewModel.addItemToWoundList(wound)
            }
        }
    }
    
    @objc
    private func dismissVC() {
        dismiss(animated: true)
    }
}


extension SetWoundingController: BottomViewDelegate {
    func moveToNextSection() {
        saveButtonTapped()
        dismissVC()
    }
    
    func moveToBackSection() {
        viewModel.clearWoundList()
        for miniImageView in miniImageViews1 {
            miniImageView.removeFromSuperview()
        }
        for miniImageView in miniImageViews2 {
            miniImageView.removeFromSuperview()
        }
        miniImageViews1.removeAll()
        miniImageViews2.removeAll()
        miniMarksLocations1.removeAll()
        miniMarksLocations2.removeAll()
        backDidActive()
    }
}



//MARK: - Delagate

extension SetWoundingController: TwoButtonViewDelegate {
    func backButtonDidTap() {
        viewModel.woundListRemoveLast()
        removeLastMiniImageView()
    }
    private func removeLastMiniImageView() {
        if  !miniImageViews1.isEmpty, isActiveMiniImageViews1, let lastMiniImageView = miniImageViews1.popLast() {
            lastMiniImageView.removeFromSuperview()
            backDidActive()
            if miniImageViews1.isEmpty {
                isActiveMiniImageViews1 = false
            }
        }
        if !miniImageViews2.isEmpty, !isActiveMiniImageViews1, let lastMiniImageView = miniImageViews2.popLast() {
            lastMiniImageView.removeFromSuperview()
            backDidActive()
            if miniImageViews2.isEmpty {
                isActiveMiniImageViews1 = true
            }
        }
        
        // Optionally, remove the last location from the marks locations
        _ = miniMarksLocations1.popLast()
          _ = miniMarksLocations2.popLast()
    }
}

extension SetWoundingController: SetWoundingControllerViewModelDelegate {
    func updateBottomView(woundListIsEmpty: Bool) {
        bottomView.setIsEnableRightButton(!woundListIsEmpty)
    }
    func viewModelDidUpdate(viewModel: SetWoundingControllerViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel = viewModel
            self?.delegate?.getWoundList(woundList: viewModel.getWoundList(), model: viewModel)
        }
    }
}
