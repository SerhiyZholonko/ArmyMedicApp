//
//  SearchViewControllerViewModel.swift
//  Dehealth
//
//  Created by apple on 30.04.2024.
//

import Foundation
import UIKit

protocol SearchViewControllerViewModelPro {
    var defenders: [SingleDefenderModel] { get set }
    func fetchDefender(with searchText: String, closure: @escaping (Result<Void, Error>) -> Void)
}

final class SearchViewControllerViewModel: SearchViewControllerViewModelPro {
    var defenders: [SingleDefenderModel] = []
    
    func fetchDefender(with searchText: String, closure: @escaping (Result<Void, Error>) -> Void) {
        let accessToken: String = StorageManager.shared.load(forKey: .accessToken) ?? ""

        // Remove spaces from search text
        let removedSpaceText = removeSpaces(from: searchText)
        guard removedSpaceText.count == 7 else {
            closure(.failure(APIError.invalidURL)) // or create a custom error
            return
        }

        let apiManager = APIManager.shared
        apiManager.getDefenderByIdentifier(identifier: removedSpaceText, accessToken: accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let defenderModel):
                self.defenders.removeAll()
                self.defenders.append(defenderModel) // Add the fetched defender
                closure(.success(()))
                
            case .failure(let error):
                print(error.localizedDescription)
                closure(.failure(error))
            }
        }
    }

    private func removeSpaces(from text: String) -> String {
        return text.replacingOccurrences(of: " ", with: "")
    }
}


