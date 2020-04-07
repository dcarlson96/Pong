//
//  MenuVCViewController.swift
//  Pong
//
//  Created by Dylan Carlson on 4/6/20.
//  Copyright © 2020 Dylan Carlson. All rights reserved.
//

import Foundation
import UIKit

enum GameType : Int {
    case easy
    case medium
    case hard
    case player2
}

class MenuVCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func twoPlayer() {
        print("tried")
        moveToGame(game: .player2)
    }
    
    @IBAction func easy() {
        print("tried1")

        moveToGame(game: .easy)
    }
    
    @IBAction func medium() {
        print("tried2")

        moveToGame(game: .medium)
    }
    
    @IBAction func hard() {
        print("tried3")

        moveToGame(game: .hard)
    }
    
    func moveToGame(game: GameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        //self.navigationController?.pushViewController(gameVC, animated: true)
        present(gameVC, animated: true)
        
    }


}
