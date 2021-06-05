//
//  CharactersDetailViewController.swift
//  BreakingBad
//

import UIKit

final class CharactersDetailViewController: UIViewController {

    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    @IBOutlet private weak var characterNicknameLabel: UILabel!
    @IBOutlet private weak var characterOccupationLabel: UILabel!
    @IBOutlet private weak var characterStatusLabel: UILabel!
    @IBOutlet private weak var characterAppearanceLabel: UILabel!

    init?(coder: NSCoder, character: Character) {
        self.character = character
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var character: Character

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = character.name
        
        characterNameLabel.text = character.name
        characterNicknameLabel.text = character.nickname
        characterOccupationLabel.text = character.occupation.first
        characterStatusLabel?.text = character.status
        characterAppearanceLabel?.text = "Season: \(character.appearance)"
        characterImageView.load(url: character.img)
    }

}
