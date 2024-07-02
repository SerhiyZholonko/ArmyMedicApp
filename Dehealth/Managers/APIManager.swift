//
//  APIManager.swift
//  Dehealth
//
//  Created by apple on 30.04.2024.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case responseError
    case decodingError
    // Add more cases as needed
}

class APIManager {
    static let shared = APIManager()
    
    private let baseURL = "https://armyhealth.org/api/"
    private let session = URLSession.shared
    
    func getDefenderByIdentifier(identifier: String, accessToken: String, completion: @escaping (Result<SingleDefenderModel, APIError>) -> Void) {
        guard let url = URL(string: "\(baseURL)defender/\(identifier)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.responseError))
                print("Invalid response: \(String(describing: response))")
                return
            }
            
            guard let data = data else {
                completion(.failure(.requestFailed))
                print("No data received")
                return
            }
            
            do {
                let defender = try JSONDecoder().decode(SingleDefenderModel.self, from: data)
                completion(.success(defender))
            } catch {
                completion(.failure(.decodingError))
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}

