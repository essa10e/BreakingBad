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
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    func setup(with character: Character) {
        //characterImageView.image = character.image
        characterNameLabel.text = character.name
        characterImageView.load(url: URL(string: character.img!)!)
    }
}
