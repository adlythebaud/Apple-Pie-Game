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
   var currentGamePlayerTwo: Game!
   let startingPlayer = arc4random_uniform(UInt32(2)) + 1
   
   // outlets
   @IBOutlet weak var treeImageView: UIImageView!
   @IBOutlet weak var correctWordLabel: UILabel!
   @IBOutlet weak var scoreLabel: UILabel!
   @IBOutlet var letterButtons: [UIButton]!     // an array of UIButtons?
   @IBOutlet weak var playerOneCurrentScore: UILabel!
   @IBOutlet weak var playerOneTotalWins: UILabel!
   
   @IBOutlet weak var playerTwoCurrentScore: UILabel!
   @IBOutlet weak var playerTwoTotalWins: UILabel!
   
   @IBOutlet weak var currentPlayerTurnLabel: UILabel!
   
   
   
   //actions
   @IBAction func buttonPressed(_ sender: UIButton) {    // all my buttons are connected to this action.
      sender.isEnabled = false                           // once that button is pushed, disable it.
      //print(sender.titleLabel)
      
      let letterSring = sender.title(for: .normal)!
      let letter = Character(letterSring.lowercased())
      currentGame.addLetter(letter: letter)
      updateGameState()                      // do the game logic. AdvanceGame() pretty much.
      
      
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      newRound()                 // when the view loads, start a newRound(), which calls a game struct. 
      
   }
   
   // functions
   func newRound() {
      if !listOfWords.isEmpty {
         
         let newWord = listOfWords.removeFirst()
         
         currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectGuessesAllowed, guessedLetters: [], currentGameScore: 0)
         
         currentGamePlayerTwo = Game(word: newWord, incorrectMovesRemaining: incorrectGuessesAllowed, guessedLetters: [], currentGameScore: 0)
         
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

