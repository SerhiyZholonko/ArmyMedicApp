//
//  InjuriesAndTraumasListDetailView.swift
//  Dehealth
//
//  Created by apple on 25.07.2024.
//

import UIKit

class CustomCollectionViewHeader: UICollectionReusableView {
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ударний:"
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    private func configureUI() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}


protocol InjuriesAndTraumasListDetailViewDelegate: AnyObject {
    func backButtonDidTap()
}

class InjuriesAndTraumasListDetailView: UIView {
    private var viewModel: InjuriesAndTraumasListDetailViewModel // Updated this line
    weak var delegate: InjuriesAndTraumasListDetailViewDelegate?
    
    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: frame.width, height: 50) // Set the header size
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private lazy var headerView: HeaderInjuriesAndTraumasListDetailView = {
        let headerView = HeaderInjuriesAndTraumasListDetailView()
        headerView.delegate = self
        return headerView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        self.viewModel = InjuriesAndTraumasListDetailViewModel(type: .percussion) // Initialize viewModel here
        super.init(frame: frame)
        configureView()
        configureUI()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func updateViewModel(viewModel: InjuriesAndTraumasListDetailViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData() // Update the collection view with the new data
    }

    private func configureView() {
        backgroundColor = .white
        alpha = 0
        layer.cornerRadius = 12
        addShadow(x: 0, y: 4, blur: 24, spread: 0, color: UIColor(red: 102/255, green: 108/255, blue: 127/255, alpha: 1), opacity: 0.25)
    }
    
    private func configureUI() {
        addSubview(headerView)
        headerView.anchor(top: topAnchor, left: leftAnchor, width: 200, height: 48)
        addSubview(collectionView)
        collectionView.anchor(top: headerView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    private func configureCollectionView() {
        collectionView.register(InjuriesAndTraumasListCell.self, forCellWithReuseIdentifier: InjuriesAndTraumasListCell.identifier)
        collectionView.register(CustomCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CustomHeaderView")
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension InjuriesAndTraumasListDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countForList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InjuriesAndTraumasListCell.identifier, for: indexPath) as! InjuriesAndTraumasListCell
        let model = viewModel.currentList[indexPath.item]
        cell.configureCell(model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected element kind")
        }
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CustomHeaderView", for: indexPath) as! CustomCollectionViewHeader
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> CGSize {
        if kind == UICollectionView.elementKindSectionHeader {
            return CGSize(width: collectionView.frame.width, height: 50) // Adjust the height as needed
        }
        return .zero
    }
}

extension InjuriesAndTraumasListDetailView: HeaderInjuriesAndTraumasListDetailViewDelegate {
    func backButtonDidTap() {
        delegate?.backButtonDidTap()
    }
}
