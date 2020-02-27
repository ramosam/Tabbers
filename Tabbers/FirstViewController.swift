//
//  FirstViewController.swift
//  Tabbers
//
//  Created by Arcaurel on 2/21/20.
//  Copyright © 2020 Ramosam. All rights reserved.
//

import UIKit


// Number Picker
class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    private let numberOptions = ["0", "1", "2", "3", "4", "5"]
    private var code = [Int(arc4random_uniform(2)), Int(arc4random_uniform(2)), Int(arc4random_uniform(2))]
    @IBOutlet weak var hintLabel: UILabel!
    private let alignArray = [NSTextAlignment.left, .center, .right]
    @IBOutlet weak var picker1: UIPickerView!
    var userScore = UserScore()
    
    // Lab 8
    var defaults = UserDefaults.standard
    
    @IBAction func hintToggle(_ sender: Any) {
        let toggle = sender as! UISwitch
        if toggle.isOn {
            hintLabel.isHidden = false
            defaults.set(false, forKey: "isHidden")
        } else {
            hintLabel.isHidden = true
            hintLabel.text = "\(code[defaults.integer(forKey: "numAlignIndex")])"
            defaults.set(true, forKey: "isHidden")
        }
    }
    

    @IBAction func pickSpinHint(_ sender: Any) {
        let hintButton = sender as! UISegmentedControl
        switch hintButton.selectedSegmentIndex {
        case 0:
            hintLabel.textAlignment = alignArray[0]
            hintLabel.text = "\(code[0])"
            defaults.set(0, forKey: "numAlignIndex")
        case 1:
            hintLabel.textAlignment = alignArray[1]
            hintLabel.text = "\(code[1])"
            defaults.set(1, forKey: "numAlignIndex")
        case 2:
            hintLabel.textAlignment = alignArray[2]
            hintLabel.text = "\(code[2])"
            defaults.set(2, forKey: "numAlignIndex")
        default:
            hintLabel.textAlignment = alignArray[0]
            defaults.set(0, forKey: "numAlignIndex")
        }
        
    }
    
    
    
    @IBAction func crackButton(_ sender: Any) {
        if picker1.selectedRow(inComponent: 0) == self.code[0] &&
        picker1.selectedRow(inComponent: 1) == self.code[1] && picker1.selectedRow(inComponent: 2) == self.code[2] {
            
            userScore.numScore += 1
            // Set defaults
            defaults.set(userScore.numScore, forKey: "numScore")
            
            let alert = UIAlertController(title: "Success", message: "You cracked the code", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Awesome", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

    
    
    @IBAction func newCodeButton(_ sender: Any) {
        code = [Int(arc4random_uniform(2)), Int(arc4random_uniform(2)), Int(arc4random_uniform(2))]
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numberOptions[row]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tabBarVC = self.tabBarController as! UserScoreTabBarController
        userScore = tabBarVC.userScore
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Get new code in range 0 ... 1
        code = [Int(arc4random_uniform(2)), Int(arc4random_uniform(2)), Int(arc4random_uniform(2))]
        hintLabel.textAlignment = alignArray[defaults.integer(forKey: "numAlignIndex")]
        hintLabel.isHidden = defaults.bool(forKey: "isHidden")
    }


}

