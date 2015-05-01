//
//  ViewController.swift
//  BullsEye
//
//  Created by babykang on 15/5/1.
//  Copyright (c) 2015年 Fiona. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    var bonus = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBAction func showAlert(sender: UIButton) {
        let difference = abs(targetValue - currentValue)
        var point = 100 - difference
        score = score + point
        
        var  title:String
        if difference == 0{
            title = "Prefect!"
            bonus += 100
        }else if difference < 5{
            title = "you almose had it!"
            bonus += 60
        }else if difference < 10{
            title = "pretty good!"
            bonus += 30
        }else{
            title = "You have played the \(round)round!"
        }
        
        let message = "You scored\(score) points!"
                      + "\n You have got \(bonus)bonus!"
        /*let message = "The Value of the slider is:\(currentValue)"
                    + "\nThe TargetValue of the slider is :\(targetValue)"
                    + "\nThe score is:\(score)"*/
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{action in
                                                                                            self.startNewRound()
                                                                                            self.updateValue()})
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
        startNewRound()
        updateValue()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateValue()
        //currentValue = lroundf(slider.value)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sliderMove (slider:UISlider){
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound (){
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
    }
    
    func updateValue(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    @IBAction func startOver(sender: UIButton) {
        startNewGame()
        updateValue()
    }
    
    func startNewGame (){
        score = 0
        round = 0
        bonus = 0
        startNewRound()
    }
}

