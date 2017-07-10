//
//  ViewController.swift
//  Apple Pie
//
//  Created by Adly Thebaud on 7/7/17.
//  Copyright © 2017 ThebaudHouse. All rights reserved.
//
//
import UIKit

class ViewController: UIViewController {

   
   
   //variables and arrays
   var listOfWords: [String] = ["running", "richard", "pi", "patel"]
   let incorrectGuessesAllowed: Int = 7
   
   var totalWins: Int = 0 {
      didSet {
         newRound()
      }
   }
   
   var totalLosses: Int = 0 {
      didSet {
         newRound()
      }
   }

   var currentGame: Game!
   
   
   
   // outlets
   @IBOutlet weak var treeImageView: UIImageView!
   @IBOutlet weak var correctWordLabel: UILabel!
   @IBOutlet weak var scoreLabel: UILabel!
   @IBOutlet var letterButtons: [UIButton]!     // an array of UIButtons?
   @IBOutlet weak var currentRoundScoreLabel: UILabel!
   
   
   //actions
   @IBAction func buttonPressed(_ sender: UIButton) {    // all my buttons have actions linked to this action.
      sender.isEnabled = false                           // once that button is pushed, disable it.
      //print(sender.titleLabel)
      
      let letterSring = sender.title(for: .normal)!
      let letter = Character(letterSring.lowercased())
      currentGame.addLetter(letter: letter)
      updateGameState()                      // do the game logic. AdvanceGame() pretty much.
   }
   
   
   /*
      update the treeImageView.image with each button press
         if a button pressed corresponds to a correct letter, update the correctWordLabel
         if a button is pressed that doesn't correspond to a correct letter, update the treeImageView.image and whatever else I need to do...
    
   */
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      newRound()                 // when the view loads, start a newRound(), which calls a game struct. 
      
   }
   
   // functions
   func newRound() {
      if !listOfWords.isEmpty {
         let newWord = listOfWords.removeFirst()      // remove the first word, set it to new word. Next game, this will remove the second word and set it to new word.
         currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectGuessesAllowed, guessedLetters: [], currentGameScore: 0)
         enableLetterButtons(true)
         updateUI()
      } else {
         enableLetterButtons(false)
      }
   }
   
   func updateUI() {
      
      var letters = [String]()
      
      for letter in currentGame.formattedWord.characters {
         letters.append(String(letter))
      }
      
      let wordWithSpacing = letters.joined(separator: " ")
      
      correctWordLabel.text = wordWithSpacing
      scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
      treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
      
      currentRoundScoreLabel.text = "Score: \(currentGame.currentGameScore)"
      
   }
   
   func updateGameState() {
      if currentGame.incorrectMovesRemaining == 0 {
         totalLosses += 1
      } else if currentGame.formattedWord == currentGame.word {
         totalWins += 1
      } else {
         updateUI()
      }
   }
   
   func enableLetterButtons(_ enable: Bool) {
      for button in letterButtons {
         button.isEnabled = enable
      }
   }
   

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


}

