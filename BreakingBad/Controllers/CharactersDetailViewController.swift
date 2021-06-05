//
//  CharactersDetailViewController.swift
//  BreakingBad
//
//  Created by Essa Aldo on 6/4/21.
//

import UIKit

final class CharactersDetailViewController: UIViewController {

    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    @IBOutlet private weak var characterNicknameLabel: UILabel!
    @IBOutlet private weak var characterOccupationLabel: UILabel!
    @IBOutlet private weak var characterStatusLabel: UILabel!
    @IBOutlet private weak var characterAppearanceLabel: UILabel!
    
//    struct ViewModel {
//        var characterName: String
//        var characterNickname: String
//        var characterOccupation: String
//        var characterStatus: String
//        var characterAppearance: [Int]
//        var characterImage: URL
//    }
    
//    var viewModel: ViewModel? {
//        didSet {
//            navigationItem.title = viewModel?.characterName
//            characterNameLabel?.text = viewModel?.characterName
//            characterNicknameLabel?.text = viewModel?.characterNickname
//            characterOccupationLabel?.text = viewModel?.characterOccupation
//            characterStatusLabel?.text = viewModel?.characterStatus
//            characterAppearanceLabel?.text = "Season: \(viewModel?.characterAppearance)"
//            characterImageView?.load(url: viewModel!.characterImage)
//        }
//    }

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
        characterAppearanceLabel?.text = "Season: \(character.appearance.description)"
        characterImageView.load(url: character.img)
    }

}
