//
//  File.swift
//  emojiquiz
//
//  Created by Robin Diddams on 2/14/18.
//  Copyright © 2018 Robin Diddams. All rights reserved.
//

import Foundation

public class HangmanString {
    
    var masterAnswer: [Character] = [Character]()
    var correctLetters: [Character] = [Character]()

    init(answer: String) {
        masterAnswer = Array(answer)
    }
    
    
    // attempt a letter, if its good it adds it to the thing and returns true
    func attempt(letter: Character) -> Bool {
        // iterate over answer and check if it contains that character
        for c in masterAnswer {
            if c == letter {
                print("master contains \(c)")
                correctLetters.append(letter)
                return true
            }
        }
        return false
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
        for c in masterAnswer {
            if c == " " {
                print("found a space")
                rend.append(" ")
            } else if isCorrectLetter(letter: c) {
                rend.append(c)
            } else {
                rend.append("_")
            }
            rend.append(" ")
        }
        return String(rend)
    }
}
