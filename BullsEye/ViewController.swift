//
//  ViewController.swift
//  BullsEye
//
//  Created by MacStudent on 2019-10-25.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isClicked = false
    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round: Int = 0
    
    
    // Outlets
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var targetLbl: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    
    
    @IBAction func infoBtnPressed(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentValue = lroundf(slider.value)
        targetValue = 1 + Int(arc4random_uniform(100))
        
        startNewRound()
        startNewGame()
        
    }
    
    
}


extension ViewController{
    
    
    // Button Actions
    
    @IBAction func btnClicked(_ sender: Any) {
        showAlert()
    }
    
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        
        slider.value = 0
        currentValue = 0
        startNewGame()
    }
    
    @IBAction func slider(_ sender: UISlider) {
        
        currentValue = Int(slider.value)
        currentValue = lroundf(slider.value)
        
    }
    
    // All Functions
    
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    
    func updateLabels() {
        targetLbl.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    //
    func showAlert(){
        
        let difference = abs(targetValue - currentValue)
        
        var points = 100 - difference
        
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50 }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        
        let message = "You scored \(points) points"
        
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        startNewRound()
    }
    
    
    func togglePressed(){
        
        isClicked.toggle()
        let label = isClicked ? "True" : "False"
        lbl.text = label
    }
    
}

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
