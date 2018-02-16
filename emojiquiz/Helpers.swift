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

//struct highscore {
//    var name: String
//    var score: Int
//}

func getHighScores() -> [(name: String, score: Int)]{
    var highscores: [(name:String, score:Int)] = [(name:String, score:Int)]()
    for i in 1...3 {
        if let name = UserDefaults.standard.object(forKey: "highschore-\(i)-name") as? String, let score = UserDefaults.standard.object(forKey: "highschore-\(i)-score") as? Int {
            highscores.append((name: name, score: score))
        } else {
            highscores.append((name: "robin", score: 0))
        }
    }
    return highscores
}

// to determine if a given score belongs on the highscoreboard
func getLowestScore() -> Int {
    let hs = getHighScores()
    return hs[2].score
}

func setHighScores(highscores: [(name: String, score: Int)]) {
    if highscores.count != 3 {
        print("it doesnt equal 3, \(highscores.count)")
    }
    var count: Int = 1
    for h in highscores {
        UserDefaults.standard.set(h.name, forKey: "highschore-\(count)-name")
        UserDefaults.standard.set(h.score, forKey: "highschore-\(count)-score")
        count += 1
    }
}

// if the given highscore is worth, add it
func addHighScore(name: String, score: Int){
    let attempt: (name: String, score: Int) = (name: name, score: score)
    var hs = getHighScores()
    hs.append(attempt)
    hs.sort { (a: (name: String, score: Int), b: (name: String, score: Int)) -> Bool in
        if a.score > b.score {
            return true
        }
        return false
    }
    setHighScores(highscores: Array(hs.prefix(3)))
}

