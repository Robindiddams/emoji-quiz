//
//  GameViewController.swift
//  emojiquiz
//
//  Created by Robin Diddams on 2/14/18.
//  Copyright © 2018 Robin Diddams. All rights reserved.
//

import UIKit
//import HangmanString

struct Quiz {
    let answer: String
    let quiz: String
}

extension Quiz {
    init(dictionary: [String: AnyObject]) {
        answer = dictionary["answer"] as! String
        quiz = dictionary["quiz"] as! String
    }
}

class GameViewController: UIViewController {
    
    var heartCount: Int = 3
    var category: String = ""
    var numQuestions: Int = 1
    var greyedOutButtons: [UIButton] = [UIButton]()
    var answer: HangmanString = HangmanString(answer: "")
    var quizPack: [(answer: HangmanString, question: String)] = [(answer: HangmanString, question: String)]()
    
    @IBAction func pressKey(_ sender: UIButton) {
        pressLetterButton(sender: sender)
    }
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    
    @IBOutlet weak var heartContainer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(category)
        print(numQuestions)
        nextRound()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup(cat: String, numQuest: Int) {
        resetAllLetterButtons()
        category = cat
        numQuestions = numQuest
        readPlist()
    }
    
    
    // Update hearts to whatevers given
    func updateHearts() {
        var h: String = ""
        for _ in 1...heartCount {
            h = "\(h)❤️"
        }
        heartContainer.text = h
    }

    func nextRound() {
        resetAllLetterButtons()
        if numQuestions > 0 {
            if let quiz = quizPack.popLast() {
                // setup answer
                answer = quiz.answer
                hintLabel.text = answer.render()
                
                //setup question
                emojiLabel.text = quiz.question
            }
            updateHearts()
            numQuestions -= 1
        } else {
            print("Game clear")
        }
    }
    
    func readPlist(){
        //read out of tge plist
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "questions", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        
        // grossly pull the answers and questions out of the dict
        if let dict = myDict {
            if let movieQuestions = dict[category] as? [[String:String]] {
                print("\(movieQuestions.count)")
                for set in movieQuestions {
                    if let a = set["answer"], let q = set["quiz"] {
                        print("\(a), \(q)")
                        quizPack.append((answer: HangmanString(answer: a), question: q))
                    }
                }
            }
        }
    }
    
    
    func pressLetterButton(sender: UIButton) {
        if let l = sender.titleLabel?.text {
            let key: Character = Character(l)
            
            // disable the button
            sender.isEnabled = false
            sender.alpha = 0.5;
            greyedOutButtons.append(sender)
            print(key)
            if answer.attempt(letter: key) {
                hintLabel.text = answer.render()
                if answer.won() {
                    print("round won")
                    nextRound()
                }
            } else {
                heartCount -= 1
                updateHearts()
                // TODO: lose heart sound effect here
            }
        
        }
    }
    
    
    // enable the buttons for pressing
    func resetAllLetterButtons() {
        for b in greyedOutButtons {
            b.isEnabled = true
            b.alpha = 1.0;
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let b: UIButton = sender as? UIButton {
            print(b)
        }
    }
 

}
