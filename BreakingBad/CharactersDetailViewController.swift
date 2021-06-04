//
//  CharactersDetailViewController.swift
//  BreakingBad
//
//  Created by Essa Aldo on 6/4/21.
//

import UIKit

class CharactersDetailViewController: UIViewController {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterNickname: UILabel!
    @IBOutlet weak var characterOccupation: UILabel!
    @IBOutlet weak var characterStatus: UILabel!
    @IBOutlet weak var characterAppearance: UILabel!
    
    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = character?.name
        
        characterName.text = character?.name
        characterNickname.text = character?.nickname
        characterOccupation.text = character?.occupation?.first
        if let character = character?.status {
            characterStatus?.text = "\(character)"
        }
        if let appearance = character?.appearance {
            characterAppearance?.text = "Season: \(appearance)"
        }
        characterImageView.load(url: URL(string: (character?.img!)!)!)
    }

}
