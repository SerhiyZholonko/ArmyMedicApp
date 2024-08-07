//
//  ColorCollectionViewCell.swift
//  Dehealth
//
//  Created by apple on 02.07.2024.
//

import UIKit

protocol ColorCollectionViewCellDelegate: AnyObject {
    func getInjuriesAndTraumasModel(model: InjuriesAndTraumasModel)
    func deleteItem(item: InjuriesAndTraumasModel)
}

class ColorCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    weak var delegate: ColorCollectionViewCellDelegate?
    static let identifier = "ColorCollectionViewCell"
    private var viewModel: InjuriesandTraumasInfoViewControllerViewModel?

    private let typeInjuryArr: [String] = ["ДТП", "Тупа травма", "Падіння"]
    private lazy var collectionView: UICollectionView = {
        let layout = CenterAlignedCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 122, height: 32) // Initial item size
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
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    func configureCell(viewModel: InjuriesandTraumasInfoViewControllerViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    private func configureUI() {
        backgroundColor = .clear
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    private func configureCollectionView() {
        collectionView.register(TypeInjuryCell.self, forCellWithReuseIdentifier: TypeInjuryCell.identifier)
    }
}

//MARK: - collectionView delegate

extension ColorCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  viewModel?.markedInjuriesandTraumasList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeInjuryCell.identifier, for: indexPath) as! TypeInjuryCell
        //TODO: - configure for cell
        cell.delegate = self
        if let viewModel = viewModel {
            let model = viewModel.markedInjuriesandTraumasList[indexPath.item]
            cell.configureCell(model: model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let prototypeCell = TypeInjuryCell()
        if let viewModel = viewModel {
            let title = viewModel.markedInjuriesandTraumasList[indexPath.item].title
            prototypeCell.injuryTitleLabel.text = title // Replace with dynamic text if needed
        }
        // Make sure to add the prototype cell to the hierarchy and set its width constraint to be dynamic
        prototypeCell.contentView.translatesAutoresizingMaskIntoConstraints = false
        let targetSize = CGSize(width: collectionView.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let size = prototypeCell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
        return CGSize(width: size.width, height: 32)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item: ", viewModel?.markedInjuriesandTraumasList[indexPath.item].title)
        if let model = viewModel?.markedInjuriesandTraumasList[indexPath.item] {
            delegate?.getInjuriesAndTraumasModel(model: model)
        }
    }

}

import UIKit

class CenterAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect),
              let collectionView = collectionView else {
            return nil
        }
        
        let contentWidth = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let cellsPerRow = Int(contentWidth / itemSize.width)
        
        var rows: [[UICollectionViewLayoutAttributes]] = [[]]
        
        for attribute in attributes {
            if attribute.representedElementCategory == .cell {
                if rows.last!.count >= cellsPerRow {
                    rows.append([attribute])
                } else {
                    rows[rows.count - 1].append(attribute) // Access last row with index
                }
            }
        }
        
        for row in rows {
            let totalRowWidth = row.reduce(0) { $0 + $1.frame.width }
            let padding = (contentWidth - totalRowWidth) / CGFloat(row.count + 1)
            var xOffset = collectionView.contentInset.left + padding
            for attribute in row {
                attribute.frame.origin.x = xOffset
                xOffset += attribute.frame.width + padding
            }
        }
        
        return attributes
    }
}


extension ColorCollectionViewCell: TypeInjuryCellDelegate {
    func deleteButtonDidTap(model: InjuriesAndTraumasModel) {
        delegate?.deleteItem(item: model)
    }
    
}
