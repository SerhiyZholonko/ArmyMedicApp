//
//  PreviousActView.swift
//  Dehealth
//
//  Created by apple on 28.05.2024.
//
protocol PreviousActViewDelegate: AnyObject {
    func plusImageViewDidTap()
}

import UIKit

class PreviousActView: UICollectionReusableView {
    //MARK: - Properties
    static let identifier = "PreviousActView"
    weak var delegate: PreviousActViewDelegate?
    private let plusImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "plus")
        iv.isUserInteractionEnabled = true
        iv.setWidth(24)
        iv.setHeight(24)
        return iv
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Коментар"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.setWidth(200)
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(plusImageViewDidTap))
        plusImageView.addGestureRecognizer(tap)
    }
    
    private func configureUI() {
        addSubview(plusImageView)
        addSubview(titleLabel)
        
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Calculate total width needed for centering
        let totalWidth = plusImageView.intrinsicContentSize.width + 5 + titleLabel.intrinsicContentSize.width
        
        // Center the plusImageView and titleLabel horizontally
        NSLayoutConstraint.activate([
            plusImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -totalWidth / 2 + plusImageView.intrinsicContentSize.width / 2),
            
            titleLabel.centerYAnchor.constraint(equalTo: plusImageView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: plusImageView.rightAnchor, constant: 5)
        ])
    }

    @objc private func plusImageViewDidTap() {
        delegate?.plusImageViewDidTap()
    }
}

