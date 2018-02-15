//
//  GameViewController.swift
//  emojiquiz
//
//  Created by Robin Diddams on 2/14/18.
//  Copyright © 2018 Robin Diddams. All rights reserved.
//

import UIKit
//import HangmanString

class GameViewController: UIViewController {
    
    var greyedOutButtons: [UIButton] = [UIButton]()
    var answer: HangmanString = HangmanString(answer: "")
    
    @IBAction func pressKey(_ sender: UIButton) {
        pressLetterButton(sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // segue.vc should pass a category and we will unpack
    func getCategoryQuestions(category: String) {
        
        
        //set answer here
    }
    
    
    func pressLetterButton(sender: UIButton) {
        
        // disable the button
        sender.isEnabled = false
        sender.alpha = 0.5;
        greyedOutButtons.append(sender)
        
        
        
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
    }
 

}
