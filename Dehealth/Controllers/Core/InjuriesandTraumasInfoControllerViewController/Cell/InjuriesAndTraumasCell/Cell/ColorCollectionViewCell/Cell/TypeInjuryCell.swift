//
//  TypeInjuryCell.swift
//  Dehealth
//
//  Created by apple on 30.07.2024.
//


import UIKit

protocol TypeInjuryCellDelegate: AnyObject {
    func deleteButtonDidTap(model: InjuriesAndTraumasModel)
}

class TypeInjuryCell: UICollectionViewCell {
    //MARK: - Properties
    private var currentModel: InjuriesAndTraumasModel?
    weak var delegate: TypeInjuryCellDelegate?
    static let identifier = "TypeInjuryCell"
    
    private let injuryImageView: UIImageView = {
        let image = UIImage(named: "fragmentary")
        let iv = UIImageView(image: image)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let injuryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Уламковий"
        label.font = .systemFont(ofSize: 14) // Assuming interLight is a custom font
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black150
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "close")
        button.setImage(image, for: .normal)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    func configureCell(model: InjuriesAndTraumasModel) {
        currentModel = model
        injuryTitleLabel.text = model.title
        injuryImageView.image = UIImage(named: model.imageName.rawValue)
    }
    private func configureUI() {
        backgroundColor = .clear
        contentView.addSubview(injuryImageView)
        contentView.addSubview(injuryTitleLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            injuryImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            injuryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            injuryImageView.widthAnchor.constraint(equalToConstant: 16),
            injuryImageView.heightAnchor.constraint(equalToConstant: 16),
            
            injuryTitleLabel.leftAnchor.constraint(equalTo: injuryImageView.rightAnchor, constant: 6),
            injuryTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            separatorView.leftAnchor.constraint(equalTo: injuryTitleLabel.rightAnchor, constant: 6),
            separatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            separatorView.widthAnchor.constraint(equalToConstant: 1),
            separatorView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
            closeButton.leftAnchor.constraint(equalTo: separatorView.rightAnchor, constant: 6),
            closeButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            closeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.black150!.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = bounds
    }
    @objc
    private func closeButtonDidTap() {
        guard let model = currentModel else { return }
        delegate?.deleteButtonDidTap(model: model)
    }
}
