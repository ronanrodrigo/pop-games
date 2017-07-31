//
//  GameDetailViewController.swift
//  PopGames
//
//  Created by Ronan R. Nunes on 31/07/17.
//  Copyright © 2017 Ronan R. Nunes. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {

    @IBOutlet private weak var gameDetailView: GameDetailView! {
        didSet {
            gameDetailView.setup(game: game, image: cover)
        }
    }

    private var game: Game!
    private var cover: UIImage!

    func setup(game: Game, cover: UIImage?) {
        self.game = game
        self.cover = cover
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = game.name
    }

}
