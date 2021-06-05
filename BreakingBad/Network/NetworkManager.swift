//
//  NetworkManager.swift
//  BreakingBad
//
//  Created by Essa Aldo on 6/3/21.
//

import Foundation

protocol Network {
    func fetchCharacters(completed: @escaping (Result<[Character], ErrorMessage>) -> Void)
}

final class NetworkManager: Network {
    static let shared = NetworkManager()
    
    private let baseURL = "https://breakingbadapi.com/api/characters"
    
    /// This function make a call to fetch all Characters
    /// - Parameter completed:
    func fetchCharacters(completed: @escaping (Result<[Character], ErrorMessage>) -> Void) {
        
        guard let url = URL(string: baseURL) else {
            completed(.failure(.invalidData))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let characterResponse = try decoder.decode([Character].self, from: data)
                completed(.success(characterResponse))
            } catch {
                completed(.failure(.invalidData))
            }            
        }
        dataTask.resume()
    }
}
