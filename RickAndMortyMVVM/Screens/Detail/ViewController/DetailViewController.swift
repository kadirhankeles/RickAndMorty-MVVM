//
//  DetailViewController.swift
//  MVVMDeneme
//
//  Created by Kadirhan Keles on 2.08.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var speciesLabel: UILabel!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var characterImage: UIImageView!
    
    private let character: Character
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        nameLabel.text = character.name
        statusLabel.text = character.status?.rawValue
        speciesLabel.text = character.species?.rawValue
        genderLabel.text = character.gender?.rawValue
        characterImage.sd_setImage(with: URL(string: character.image!))
        // Configure other UI elements with character details
    }
}
