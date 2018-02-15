//
//  rename this to helper methods
//  emojiquiz
//
//  Created by Robin Diddams on 2/14/18.
//  Copyright © 2018 Robin Diddams. All rights reserved.
//

import Foundation

public class HangmanString {
    
    var masterAnswer: [Character] = [Character]()
    var correctLetters: [Character] = [Character]()
    var win: Bool = false

    init(answer: String) {
        masterAnswer = Array(answer.uppercased())
    }
    
    
    // attempt a letter, if its good it adds it to the thing and returns true
    func attempt(letter: Character) -> Bool {
        // iterate over answer and check if it contains that character
        if masterAnswer.contains(letter) {
            correctLetters.append(letter)
            return true
        }
        return false
    }
    
    func won() -> Bool {
        return win
    }
    
    
    
    func isCorrectLetter(letter: Character) -> Bool {
        for guessedChar in correctLetters {
            if guessedChar == letter {
                return true
            }
        }
        return false
    }
    
    // returns the answer with underscores where unguessed letters are
    func render() -> String {
        var rend: [Character] = [Character]()
        var noBlanks: Bool = true
        for c in masterAnswer {
            if c == " " {
                print("found a space")
                rend.append(" ")
            } else if isCorrectLetter(letter: c) {
                rend.append(c)
            } else {
                rend.append("_")
                noBlanks = false
            }
            rend.append(" ")
        }
        if noBlanks {
            win = noBlanks
        }
        return String(rend)
    }
}


