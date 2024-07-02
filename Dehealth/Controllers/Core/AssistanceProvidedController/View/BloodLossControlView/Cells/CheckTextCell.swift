//
//  CheckTextCell.swift
//  Dehealth
//
//  Created by apple on 13.06.2024.
//

import UIKit

protocol CheckTextCellDelegate: AnyObject {
    func pikerViewDidTap(counter: Int, title: String?)
}

class CheckTextCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "CheckTextCell"
    weak var delegate: CheckTextCellDelegate?
    private let pikerView: UIImageView = {
        let image = UIImage(named: "Empty")
        let iv = UIImageView(image: image)
        iv.isUserInteractionEnabled = true // Enable user interaction
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(pikerViewDidTap))
        pikerView.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    func refreshPiker() {
        pikerView.image = UIImage(named: "Empty")
    }
    private func configureUI() {
        contentView.alpha = 1
        addSubview(pikerView)
        
        pikerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pikerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            pikerView.widthAnchor.constraint(equalToConstant: 28),
            pikerView.heightAnchor.constraint(equalToConstant: 28),
            pikerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: pikerView.rightAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    @objc private func pikerViewDidTap() {
        if pikerView.image == UIImage(named: "Empty") {
            pikerView.image = UIImage(named: "Check")
            delegate?.pikerViewDidTap(counter: 1, title: titleLabel.text)
        } else  {
            pikerView.image = UIImage(named: "Empty")
            delegate?.pikerViewDidTap(counter: -1, title: titleLabel.text)
        }
       
    }
}



#Preview() {
    AssistanceProvidedController()
}
