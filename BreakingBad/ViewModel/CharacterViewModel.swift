//
//  CharacterViewModel.swift
//  BreakingBad
//
//  Created by Essa Aldo on 6/3/21.
//

import UIKit

protocol CharacterDelgate {
    func reloadData()
}

final class CharacterViewModel {
    
    private var characters = [Character]()
    
    private let delegate: CharacterDelgate?
    private var network: Network?
    
    init(delegate: CharacterDelgate?, network: Network = NetworkManager()) {
        self.delegate = delegate
        self.network = network
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        NetworkManager.shared.fetchCharacters() { [weak self] result in
            switch result {
            case .success(let result):
                self?.characters.append(contentsOf: result)
                self?.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// This function returns number of characters.
    /// - Parameter section: collectionView section
    /// - Returns: returns an integer
    func numberOfItemsInSection(section: Int) -> Int {
        return characters.count
    }
    
    /// This function returns a specific 'Character'
    /// - Parameter row: an integer of the specified 'Character'
    /// - Returns: return a 'Character'
    func getData(row: Int) -> Character? {
        return characters[row]
    }
    
    /// This function returns a 'Character' of specific indexPath
    /// - Parameter index: an integer
    /// - Returns: return a 'Character'
    func characterItem(at index: Int) -> Character {
        return characters[index]
    }
}
