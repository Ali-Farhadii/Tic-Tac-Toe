//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by ali farhadi on 7/6/1398 AP.
//  Copyright © 1398 Ali Farhadi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    @IBOutlet weak var numberOfGamesLabel: UILabel!
    @IBOutlet weak var turnSign1: UIView!
    @IBOutlet weak var turnSign2: UIView!
    @IBOutlet weak var playerOneWinLabel: UILabel!
    @IBOutlet weak var playerTwoWinLabel: UILabel!
    @IBOutlet weak var noOneWin: UILabel!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var boardImage: UIImageView!
    
    
    enum Player {
        case first
        case secound
        case neither
    }

    var playerTurn: Player = .first
    var buttonState = [0,0,0,0,0,0,0,0,0]
    var numberOfGames = 0
    var playerOneScore = 0
    var playerTwoScore = 0
    
    // Main Buttons
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        guard buttonState[sender.tag-1] == 0 else {
            return
        }
        
        if playerTurn == .first {
            sender.setTitle("O", for: .normal)
            sender.setTitleColor(.green, for: .normal)
            
            // Set state of button for check that is selected or not and which player select it
            buttonState[sender.tag-1] = 1
            
            playerTurn = .secound
            checkForWinner()
            turnSign1.isHidden = !turnSign1.isHidden
            turnSign2.isHidden = !turnSign2.isHidden
        }
        else {
            sender.setTitle("X", for: .normal)
            sender.setTitleColor(.yellow, for: .normal)
            
            // Set state of button for check that is selected or not and which player select it
            buttonState[sender.tag-1] = 2
            
            playerTurn = .first
            checkForWinner()
            turnSign1.isHidden = !turnSign1.isHidden
            turnSign2.isHidden = !turnSign2.isHidden
        }
        
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
        guard !(buttonState.contains(0) && !buttonState.contains(1) && !buttonState.contains(2)) else {
            return
        }
        
        numberOfGames += 1
        numberOfGamesLabel.text = String(numberOfGames)
        
        playerOneWinLabel.isHidden = true
        playerTwoWinLabel.isHidden = true
        noOneWin.isHidden = true
        mainStackView.isHidden = false
        boardImage.isHidden = false
        turnSign1.isHidden = false
        turnSign2.isHidden = true
        
        if playerTurn == .secound {
            playerTurn = .first
        }
        
        for i in 1...9 {
            
            // Clear text of buttons
            if let button = view.viewWithTag(i) as? UIButton {
                button.setTitle("", for: .normal)
            }
            // Reset state of buttons for use again
            buttonState[i-1] = 0
        }
    }
    
//MARK: Methods
    
    // Update UI
    func updateUI(player: Player) {
        
        mainStackView.isHidden = true
        boardImage.isHidden = true
        turnSign1.isHidden = false
        turnSign2.isHidden = false
        
        if player == .first {
            playerOneWinLabel.isHidden = false
            noOneWin.isHidden = true
            playerOneScore += 1
            playerOneScoreLabel.text = String(playerOneScore)
        }
        else if player == .secound {
            playerTwoWinLabel.isHidden = false
            noOneWin.isHidden = true
            playerTwoScore += 1
            playerTwoScoreLabel.text = String(playerTwoScore)
        }
        else if player == .neither {
            noOneWin.isHidden = false
            playerOneWinLabel.isHidden = true
            playerTwoWinLabel.isHidden = true
        }
    }
    
    // Conditions of wining
    var winCombination = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    // CheckForWinner
    func checkForWinner() {
        
        for index in winCombination {
            
            if buttonState[index[0]] != 0 && buttonState[index[0]] == 1 && buttonState[index[1]] == 1 && buttonState[index[2]] == 1 {
                
                updateUI(player: .first)
                break
            }
            else if buttonState[index[0]] != 0 && buttonState[index[0]] == 2 && buttonState[index[1]] == 2 && buttonState[index[2]] == 2 {
            
                updateUI(player: .secound)
                break
            }
            else if !buttonState.contains(0) {
                updateUI(player: .neither)
            }
        }
 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerOneWinLabel.isHidden = true
        playerTwoWinLabel.isHidden = true
        turnSign2.isHidden = true
        noOneWin.isHidden = true
    }
    
}

