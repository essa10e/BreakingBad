//
//  CharacterSearch.swift
//  BreakingBad
//
//  Created by Essa Aldo on 6/4/21.
//

import UIKit

class CharacterSearch: NSObject, UICollectionViewDataSource {
    
    var characters = [Character]()
    var filteredCharacters = [Character]()
    var dataChanged: (() -> Void)?

    var filterText: String? {
        didSet {
            filteredCharacters = characters.searchByName(filterText)
            self.dataChanged?()
        }
    }
    
    var filterAppearance: Int? {
        didSet {
            filteredCharacters = characters.searchByAppearance(filterAppearance)
            self.dataChanged?()
        }
    }
    
    func fetch(_ urlString: String) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        decoder.decoding([Character].self, fromURL: urlString) { character in
            self.characters = character
            self.filteredCharacters = character
            self.dataChanged?()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
        let character = filteredCharacters[indexPath.row]
        cell.setup(with: character)
        return cell
    }
    
}

extension JSONDecoder {
    func decoding<T: Decodable>(_ type: T.Type, fromURL url: String, completion: @escaping (T) -> Void) {
        guard let url = URL(string: url) else { fatalError("Invalid URL passed.") }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                
                let downloadedData = try self.decode(type, from: data)
                
                DispatchQueue.main.async {
                    completion(downloadedData)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
     }
}
