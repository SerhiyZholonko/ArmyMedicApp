//
//  PathDropView.swift
//  Dehealth
//
//  Created by apple on 12.06.2024.
//

import UIKit

protocol PathDropViewDelegate: AnyObject {
    func inputPathSelected(title: String)
}

class PathDropView: UIView {
    //MARK: - Properties
    weak var delegate: PathDropViewDelegate?
    private let inputPathList = ["Не обрано", "Внітрушньом’язовий", "Внітрішньокістковий", "Внутрішньосудинний"]
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        return tv
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func configureUI() {
        backgroundColor = .clear
        addSubview(tableView)
        tableView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
    }
}

extension PathDropView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputPathList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = inputPathList[indexPath.row]
        
        // Reset the corner radius and masked corners for reuse
        cell.layer.cornerRadius = 0
        cell.layer.maskedCorners = []
        
        // Add corner radius to the first cell
        if indexPath.row == 0 {
            cell.layer.cornerRadius = 10
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        // Add corner radius to the last cell
        if indexPath.row == inputPathList.count - 1 {
            cell.layer.cornerRadius = 10
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        // To ensure that the corner radius is applied correctly
        cell.clipsToBounds = true
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = inputPathList[indexPath.row]
        delegate?.inputPathSelected(title: title)
    }
}

#Preview() {
    AssistanceProvidedController()
}
