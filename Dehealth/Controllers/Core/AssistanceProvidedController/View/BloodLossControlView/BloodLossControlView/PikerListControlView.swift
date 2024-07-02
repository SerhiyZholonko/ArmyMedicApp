//
//  BloodLossControlView.swift
//  Dehealth
//
//  Created by apple on 12.06.2024.
//

import UIKit

protocol PikerListControlViewDelegate: AnyObject {
    func saveBloodControlButtonDidTap(titles: [String])
    func saveBreathingButtonDidTap(titles: [String])
    func saveNoteButtonDidTap(titles: [String])
}
enum PikerListControlViewStyle {
    case blood
    case breathing
    case note
}
class PikerListControlView: UIView {
    //MARK: - Properties
    var height: CGFloat = 308
    weak var delegate: PikerListControlViewDelegate?
    private let style: PikerListControlViewStyle
    private var bloodTitleCounter: Int = 0
    private var selectedArrayOfTitles: [String] = []
    var arrayOfTitles: [String] = []
    
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        return view
    }()
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    private let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    private let bressureBandageView: CheckTextView = {
        let view = CheckTextView()
        return view
    }()
    private lazy var buttonsView: CancelSaveView = {
       let view = CancelSaveView()
        view.setTitleForLeftButton("Зберегти")
        view.setTitleForRightButton("Cкинути")
        view.delegate = self
        return view
    }()
    
    //MARK: - Init
    init(frame: CGRect, height: CGFloat, style: PikerListControlViewStyle) {
        self.height = height
        self.style = style
        super.init(frame: frame)
        configureTableView()
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    func setHeightForView(_ height: CGFloat) {
        self.height = height
    }
    func setListArray(_ list: [String]) {
        self.arrayOfTitles = list
        tableView.reloadData()
        updateBgViewHeight()
    }
    
    func setTitle(_ title: String) {
        self.title.text = title
    }
    func updateBgViewHeight() {
       let baseHeight: CGFloat = 60 // for title and padding
       let rowHeight: CGFloat = 44
       let buttonViewHeight: CGFloat = 60
       let maxRows = 10 // maximum rows to display before scrolling
       let totalRows = 10
        min(arrayOfTitles.count, maxRows)
       let totalHeight = baseHeight + (CGFloat(totalRows) * 44) + buttonViewHeight
       
       bgView.heightAnchor.constraint(equalToConstant: totalHeight).isActive = true
   }
    private func configureUI() {
        backgroundColor = .black.withAlphaComponent(0.7)
        addSubview(bgView)
        
        bgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            bgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            bgView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            bgView.heightAnchor.constraint(equalToConstant: height) // Initial height
        ])
        
        addSubview(title)
        title.anchor(top: bgView.topAnchor, left: bgView.leftAnchor, paddingTop: 20, paddingLeft: 20)
        
        addSubview(tableView)
        tableView.anchor(top: title.bottomAnchor, left: bgView.leftAnchor, bottom: bgView.bottomAnchor, right: bgView.rightAnchor, paddingBottom: 60)
        
        addSubview(buttonsView)
        buttonsView.anchor(left: bgView.leftAnchor, bottom: bgView.bottomAnchor, right: bgView.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, height: 60)
    }
    
    private func configureTableView() {
        tableView.register(CheckTextCell.self, forCellReuseIdentifier: CheckTextCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
  
}

extension PikerListControlView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CheckTextCell.identifier, for: indexPath) as! CheckTextCell
        cell.selectionStyle = .none
        let title = arrayOfTitles[indexPath.row]
        cell.setTitle(title)
        cell.refreshPiker()
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}

extension PikerListControlView: CancelSaveViewDelegate {
    func moveToNextSection() {
        if bloodTitleCounter != 0 {
            switch style {
            case .blood:
                delegate?.saveBloodControlButtonDidTap(titles: selectedArrayOfTitles)
            case .breathing:
                delegate?.saveBreathingButtonDidTap(titles: selectedArrayOfTitles)
            case .note:
                delegate?.saveNoteButtonDidTap(titles: selectedArrayOfTitles)
            }
        }
    }
    
    func moveToBackSection() {
        bloodTitleCounter = 0
        tableView.reloadData()
        buttonsView.backButton.tintColor = .black500
        buttonsView.backButton.layer.borderColor = UIColor.black200?.cgColor
    }
}

extension PikerListControlView: CheckTextCellDelegate {
    func pikerViewDidTap(counter: Int, title: String?) {
        if counter == 1, let title = title {
            self.selectedArrayOfTitles.insert(title, at: 0)
        } else if let title = title {
            self.selectedArrayOfTitles = selectedArrayOfTitles.filter { $0 != title }
        }
        bloodTitleCounter += counter
        if bloodTitleCounter == 0 {
            buttonsView.backButton.tintColor = .black500
            buttonsView.backButton.layer.borderColor = UIColor.black200?.cgColor
            buttonsView.backButton.isEnabled = false
        } else {
            buttonsView.backButton.tintColor = .black700
            buttonsView.backButton.layer.borderColor = UIColor.black400?.cgColor
            buttonsView.backButton.isEnabled = true
        }
    }
}

#Preview() {
    AssistanceProvidedController()
}

