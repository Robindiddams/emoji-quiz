//
//  LeaderboardController.swift
//  emojiquiz
//
//  Created by Robin Diddams on 2/14/18.
//  Copyright © 2018 Robin Diddams. All rights reserved.
//

import UIKit

class LeaderboardController: UIViewController {

    @IBOutlet weak var numberThreeLabel: UILabel!
    @IBOutlet weak var numberTwoLabel: UILabel!
    @IBOutlet weak var numberOneLabel: UILabel!
    
    @IBOutlet weak var numberThreeScore: UILabel!
    @IBOutlet weak var numberTwoScore: UILabel!
    @IBOutlet weak var numberOneScore: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderHighscores()
        print("didload")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func renderHighscores() {
        var hs = getHighScores()
        print("hs count: \(hs.count)")
        var scoreLabels: [UILabel] = [UILabel]()
        var nameLabels: [UILabel] = [UILabel]()
        
        //setup labels
        scoreLabels.append(numberOneScore)
        scoreLabels.append(numberTwoScore)
        scoreLabels.append(numberThreeScore)
        
        nameLabels.append(numberOneLabel)
        nameLabels.append(numberTwoLabel)
        nameLabels.append(numberThreeLabel)
        
        //update labels
        for i in 0...2 {
            scoreLabels[i].text = "\(hs[i].score)"
            nameLabels[i].text = "\(hs[i].name)"
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
