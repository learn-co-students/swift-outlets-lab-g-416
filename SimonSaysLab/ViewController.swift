//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    func winCheck() {
        if (simonSaysGame.chosenColors.count == simonSaysGame.patternToMatch.count){
        if simonSaysGame.wonGame(){
                winLabel.text = "You won!"
                winLabel.isHidden = false
                
            }else{
                winLabel.text = "You lost!"
                winLabel.isHidden = false
                
            }
            playAgain.isHidden = false
            
        }
        
        
    }
    func resetGame(){
        playAgain.isHidden = true
        winLabel.isHidden = true
    }

        @IBAction func guessRed(_ sender: Any) {
        simonSaysGame.guessRed()
        winCheck()
        
    }
    @IBAction func guessGreen(_ sender: Any) {
        simonSaysGame.guessGreen()
        winCheck()
    }
    @IBAction func guessYellow(_ sender: Any) {
        simonSaysGame.guessYellow()
        
        winCheck()
    }
    @IBAction func guessedBlue(_ sender: Any) {
        simonSaysGame.guessBlue()
        winCheck()
    }
    @IBAction func playAgain(_ sender: Any) {
        resetGame()
        
        simonSaysGame = SimonSays()
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
        playAgain.isHidden = true
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
