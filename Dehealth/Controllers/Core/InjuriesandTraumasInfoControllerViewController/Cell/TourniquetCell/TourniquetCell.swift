//
//  TourniquetCell.swift
//  Dehealth
//
//  Created by apple on 23.02.2024.
//

import UIKit

protocol TourniquetCellDelegate: AnyObject {
    func didTapEditButton(on cell: PlaceOnBodyCollectionViewCell, at cellFrameInSuperview: CGRect)
    func addItem()
}
enum TourniquetCellStyle {
    case tourniquet
    case photoAndVideo
}
class TourniquetCell: UICollectionViewCell {
	 //MARK: - Properties
    static let identifier = "TourniquetCell"
    weak var delegate: TourniquetCellDelegate?
    private var viewModel: InjuriesandTraumasInfoViewControllerViewModel?
	let buttonTitleColor = "#333333".hexColor()
	let titleLabelColor = "#222222".hexColor()
	private lazy var titleLabel = CustomLabel(textLabel: "Турнікет", textColorLabel: titleLabelColor, fontLabel: .interMedium(size: 18))
    private lazy var addButton: UIButton = {
        let button = UIButton()
        let image =  UIImage(named: "plus")
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    private lazy var placeOnBodyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        return cv
    }()
	 //MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
        setupButtons()
        configureCollectionView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	//MARK: - Functions
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    func setTitle(title: String) {
        titleLabel.text = title
    }
    func updateViewModel(viewModel: InjuriesandTraumasInfoViewControllerViewModel) {
        self.viewModel = viewModel
        placeOnBodyCollectionView.reloadData()
    }
    private func configureCollectionView() {
        placeOnBodyCollectionView.dataSource = self
        placeOnBodyCollectionView.delegate = self
        placeOnBodyCollectionView.register(PlaceOnBodyCollectionViewCell.self, forCellWithReuseIdentifier: PlaceOnBodyCollectionViewCell.identifier)
    }
	private func configureUI() {
		contentView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 16)
		contentView.backgroundColor = .white
		contentView.layer.cornerRadius = 12
		titleLabel.setHeight(48)
		addButton.setHeight(48)
		addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingLeft: 16)
		addSubview(addButton)
		addButton.anchor(top: contentView.topAnchor, right: contentView.rightAnchor, paddingTop: 12,  paddingRight: 16, width: 24, height: 24)
        addSubview(placeOnBodyCollectionView)
        placeOnBodyCollectionView.anchor(top: titleLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor)
	}
    
    private func setupButtons() {
        addButton.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
    }
    @objc
    private func addButtonDidTap() {
        delegate?.addItem()
    }
}


extension TourniquetCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.tourniquetList.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceOnBodyCollectionViewCell.identifier, for: indexPath) as! PlaceOnBodyCollectionViewCell
        cell.delegate = self
//        cell.isEdit = false
        cell.editButtonTapped()
        if let viewModel = viewModel {
            cell.configureCell(model: viewModel.getTourniquet(indexPath: indexPath))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 103)
    }
}



extension TourniquetCell: PlaceOnBodyCollectionViewCellDelegate {
    
    func didTapEditButton(on cell: PlaceOnBodyCollectionViewCell) {
        guard let indexPath = placeOnBodyCollectionView.indexPath(for: cell) else { return }

        // Get the cell's frame in the collection view's coordinate system
        let cellFrame = placeOnBodyCollectionView.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
        let cellFrameInSuperview = placeOnBodyCollectionView.convert(cellFrame, to: placeOnBodyCollectionView.superview)

        // Create an overlay view
        let overlayView = UIView(frame: bounds)
        overlayView.backgroundColor = .clear
        //UIColor.black.withAlphaComponent(0.5)
        overlayView.tag = 999 // Set a tag to identify the overlay view later

        // Add the custom subview to the overlay
        let customSubview = EditView()
        overlayView.addSubview(customSubview)
        customSubview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customSubview.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: cellFrameInSuperview.minX - 40),
            customSubview.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: cellFrameInSuperview.maxY - 60),
            customSubview.heightAnchor.constraint(equalToConstant: 83),
            customSubview.widthAnchor.constraint(equalToConstant: 200)
        ])
        // Add a tap gesture recognizer to dismiss the overlay
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissOverlay(_:)))
        overlayView.addGestureRecognizer(tapGesture)
        // Add the overlay to the main view
        addSubview(overlayView)
    }

    @objc private func dismissOverlay(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
        placeOnBodyCollectionView.reloadData()
    }
}
