//
//  game.swift
//  Apple Pie
//
//  Created by Adly Thebaud on 7/8/17.
//  Copyright © 2017 ThebaudHouse. All rights reserved.
//

import Foundation


struct Game {
   var word: String
   var incorrectMovesRemaining: Int
   var guessedLetters: [Character]
   mutating func addLetter(letter: Character) {
      guessedLetters.append(letter)
      
      if !word.characters.contains(letter) {
         incorrectMovesRemaining -= 1
      }
   }
   
   var formattedWord: String {
      var guessedWord = ""
      for letter in word.characters {
         if guessedLetters.contains(letter) {
            guessedWord += "\(letter)"
         } else {
            guessedWord += "_"
         }
      }
      return guessedWord
   }
   
   
   
   
}

