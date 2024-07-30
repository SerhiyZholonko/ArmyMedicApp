//
//  SetWoundingController.swift
//  Dehealth
//
//  Created by apple on 28.02.2024.
//

import UIKit

class SetWoundingController: UIViewController {
    // MARK: - Properties
    private var image1Name: String = ""
    private let mainImage1 = UIImage(named: "body front")
    private let mainImage2 = UIImage(named: "body back")
    private let mainImageView1 = UIImageView()
    private let mainImageView2 = UIImageView()
    private var miniImageViews1 = [UIImageView]()
    private var miniImageViews2 = [UIImageView]()
    private var miniMarksLocations1 = [CGPoint]()
    private var miniMarksLocations2 = [CGPoint]()
    
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
    
        private let forwardBackwardView: TwoButtonView = {
         let view = TwoButtonView()
            return view
        }()
    
        private lazy var bottomView: BottomView = {
            let view = BottomView()
            view.setTitleForRightButton("Очистити")
            view.setTitleForLeftButton("Зберегти")
            view.setIsEnableRightButton(true)
            view.delegate = self
            return view
        }()
    
    // MARK: - Lifecycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addScrollView()
    }
    
    // MARK: - Functions
    func setupModel(_ model: InjuriesAndTraumasModel) {
         imageSubTitleLabel.setTitle(model) // Uncomment if needed
        image1Name = model.imageName
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
    
    private func addMiniMark1(at location: CGPoint) {
        let miniImageView = UIImageView(image: UIImage(named: image1Name))
        miniImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        miniImageView.center = location
        mainImageView1.addSubview(miniImageView)
        miniImageViews1.append(miniImageView)
        miniMarksLocations1.append(location)
    }
    
    private func addMiniMark2(at location: CGPoint) {
        let miniImageView = UIImageView(image: UIImage(named: image1Name))
        miniImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        miniImageView.center = location
        mainImageView2.addSubview(miniImageView)
        miniImageViews2.append(miniImageView)
        miniMarksLocations2.append(location)
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
        print("Mini marks locations for image 1: \(miniMarksLocations1)")
        print("Mini marks locations for image 2: \(miniMarksLocations2)")
        // Save the locations to your desired storage or use them as needed
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
        
    }
}
