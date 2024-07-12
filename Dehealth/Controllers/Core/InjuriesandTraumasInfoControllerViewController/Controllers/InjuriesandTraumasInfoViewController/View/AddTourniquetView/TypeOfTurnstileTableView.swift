//
//  TypeOfTurnstileTableView.swift
//  Dehealth
//
//  Created by apple on 09.07.2024.
//
//
//import UIKit
//
//class TypeOfTurnstileTableView: UIView {
//    
//     //MARK: - Properties
//    private let tableView: UITableView = {
//        let tv = UITableView(frame: .zero)
//        tv.alpha = 0
//        return tv    }()
//     //MARK: - Init
//    override init(frame: CGRect, viewModel: ) {
//        <#code#>
//    }
//     //MARK: - Functions
//    
//}
//
//extension TypeOfTurnstileTableView: UITableViewDelegate, UITableViewDataSource {
//    private func configureTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.typeOfTurnstileList.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
//        let typeOfTurnstileString = viewModel.typeOfTurnstileList[indexPath.row]
//        cell.textLabel?.text = typeOfTurnstileString
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let typeOfTurnstileString = viewModel.typeOfTurnstileList[indexPath.row]
//        typeOfTurnstileView.setTitle(typeOfTurnstileString)
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 56
//    }
//    
//}
