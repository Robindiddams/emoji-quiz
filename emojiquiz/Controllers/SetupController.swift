//
//  SetupController.swift
//  emojiquiz
//
//  Created by Robin Diddams on 2/14/18.
//  Copyright © 2018 Robin Diddams. All rights reserved.
//

import UIKit

class SetupController: UIViewController {
    
    @IBOutlet weak var questionCount: UILabel!
    @IBOutlet weak var categorySC: UISegmentedControl!
    @IBOutlet weak var questionStepper: UIStepper!
    
    @IBAction func questionStepperChange(_ sender: UIStepper) {
        print("\(sender.value)")
        questionCount.text = "\(Int32(sender.value))"
        questions = Int(sender.value)
    }
    @IBAction func categoryChange(_ sender: UISegmentedControl) {
        if let cat = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            if categories.contains(cat) {
                category = cat
            }
        }
        print("category:\(category)")
    }
    
    
    let categories: [String] = ["Movies", "Animals"]
    var category: String = ""
    var questions: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup vars
        if let cat = categorySC.titleForSegment(at: categorySC.selectedSegmentIndex) {
            if categories.contains(cat) {
                category = cat
            }
        }
        print("category:\(category)")
        questions = Int(questionStepper.value)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("prepare")
        if let _ = sender as? UIButton, let game = segue.destination as? GameViewController {
            print("button")
            game.setup(cat: category, numQuest: questions)
        }
    }
    

}
