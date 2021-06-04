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
class CharacterViewModel {
    
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
    
    func numberOfItemsInSection(section: Int) -> Int {
        return characters.count
    }
    
    func getData(row: Int) -> Character? {
        return characters[row]
    }

    func characterItem(at index: Int) -> Character {
        return characters[index]
    }
}
