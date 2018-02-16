//
//  GameViewController.swift
//  emojiquiz
//
//  Created by Robin Diddams on 2/14/18.
//  Copyright © 2018 Robin Diddams. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?


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
                
                //animation - modified from an answer from
                // https://stackoverflow.com/questions/38988043/swift-fade-in-and-out-a-label
                
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
                    self.emojiLabel.alpha = 0.0
                }, completion: {
                    finished in
                    
                    if finished {
                        //Once the label is completely invisible, set the text and fade it back in
                        
                        //setup question
                        self.emojiLabel.text = quiz.question
                        
                        // Fade in
                        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn, animations: {
                            self.emojiLabel.alpha = 1.0
                        }, completion: nil)
                    }
                })
                
            }
            updateHearts()
            numQuestions -= 1
        } else {
            print("Game clear")
            playSound(sound: "win")
            //TODO: play win sound and show notification
            let alert = UIAlertController(title: "Congrats!", message: "You beat answered all the questions", preferredStyle: UIAlertControllerStyle.alert)
            // from  https://medium.com/@chan.henryk/alert-controller-with-text-field-in-swift-3-bda7ac06026c
            let action = UIAlertAction(title: "save!", style: .default) { (alertAction) in
                if let _ = self.tabBarController?.selectedIndex {
                    self.tabBarController?.selectedIndex = 1
                }
            }
            alert.addTextField { (textField) in
                textField.placeholder = "Enter your name"
            }
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
            
        }
    }
    
    func readPlist(){
        //read out of the plist
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
                    // TODO add an animation here between rounds
                    // Animation added inside nextRound() function
                    
                    nextRound()
                }
            } else {
                heartCount -= 1
                updateHearts()
                // TODO: lose heart sound effect here
                playSound(sound: "lose")
            }
        
        }
    }
    
    func playSound(sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "m4a") else { return }
        print("hello")
        do {
            // i got this https://stackoverflow.com/questions/32036146/how-to-play-a-sound-using-swift
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.m4a.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
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
        
        print("heeeeeeey")
        if let b: UIButton = sender as? UIButton {
            print(b)
        }
    }
}
