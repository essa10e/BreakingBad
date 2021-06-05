//
//  CharacterCell.swift
//  BreakingBad
//
//  Created by Essa Aldo on 6/3/21.
//

import UIKit


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}

class CharacterCell: UICollectionViewCell {
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    
    struct ViewModel {
        var charName: String
        var imagurl: URL
    }
    
    var viewModel: ViewModel? {
        didSet {
            characterNameLabel.text = viewModel?.charName
        }
    }
    func setup(with character: Character) {
        //characterImageView.image = character.image
        characterNameLabel.text = character.name
        characterImageView.load(url: character.img)
    }
}
