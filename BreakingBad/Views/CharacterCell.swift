//
//  CharacterCell.swift
//  BreakingBad
//

import UIKit
import Kingfisher

class CharacterCell: UICollectionViewCell {
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    
    func setup(with character: Character) {
        characterNameLabel.text = character.name
        let resource = ImageResource(downloadURL: character.img)
        characterImageView.kf.setImage(with: resource)
    }
}
