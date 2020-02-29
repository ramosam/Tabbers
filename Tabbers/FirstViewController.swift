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
    private var code = [Int(arc4random_uniform(6)), Int(arc4random_uniform(6)), Int(arc4random_uniform(6))]
    @IBOutlet weak var hintLabel: UILabel!
    private let alignArray = [NSTextAlignment.left, .center, .right]
    @IBOutlet weak var picker1: UIPickerView!
    var userScore = UserScore()
    @IBOutlet weak var hintToggler: UISwitch!
    @IBOutlet weak var spinIndex: UISegmentedControl!
    
    private let isHidden = "isHidden"
    private let alignKey = "numAlignIndex"
    private let alignIndexDefault = 0
    private let numScore = "numScore"
    private let hintToggleIsOn = "hintToggleIsOn"
    private let buttonIndex = "buttonIndex"
    
    
    @IBAction func hintToggle(_ sender: Any) {
        let toggle = sender as! UISwitch
        if toggle.isOn {
            hintLabel.isHidden = false
            hintLabel.textAlignment = alignArray[UserDefaults.standard.integer(forKey: alignKey)]
            hintLabel.text = "\(code[UserDefaults.standard.integer(forKey: alignKey)])"
            UserDefaults.standard.set(false, forKey: isHidden)
            UserDefaults.standard.set(true, forKey: hintToggleIsOn)
            
        } else {
            hintLabel.isHidden = true
            hintLabel.textAlignment = alignArray[UserDefaults.standard.integer(forKey: alignKey)]
            hintLabel.text = "\(code[UserDefaults.standard.integer(forKey: alignKey)])"
            UserDefaults.standard.set(true, forKey: isHidden)
            UserDefaults.standard.set(false, forKey: hintToggleIsOn)
        }
    }
    

    @IBAction func pickSpinHint(_ sender: Any) {
        let hintButton = sender as! UISegmentedControl
        switch hintButton.selectedSegmentIndex {
        case 0:
            hintLabel.textAlignment = alignArray[0]
            hintLabel.text = "\(code[0])"
            UserDefaults.standard.set(0, forKey: alignKey)
            UserDefaults.standard.set(0, forKey: buttonIndex)
        case 1:
            hintLabel.textAlignment = alignArray[1]
            hintLabel.text = "\(code[1])"
            UserDefaults.standard.set(1, forKey: alignKey)
            UserDefaults.standard.set(1, forKey: buttonIndex)
        case 2:
            hintLabel.textAlignment = alignArray[2]
            hintLabel.text = "\(code[2])"
            UserDefaults.standard.set(2, forKey: alignKey)
            UserDefaults.standard.set(2, forKey: buttonIndex)
        default:
            hintLabel.textAlignment = alignArray[0]
            hintLabel.text = "\(code[0])"
            UserDefaults.standard.set(0, forKey: alignKey)
            UserDefaults.standard.set(0, forKey: buttonIndex)
        }
        
    }
    
    
    
    @IBAction func crackButton(_ sender: Any) {
        if picker1.selectedRow(inComponent: 0) == self.code[0] &&
        picker1.selectedRow(inComponent: 1) == self.code[1] && picker1.selectedRow(inComponent: 2) == self.code[2] {
            
            userScore.numScore += 1
            // Set defaults
            UserDefaults.standard.set(userScore.numScore, forKey: numScore)
            
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
        if !UserDefaults.standard.bool(forKey: "defaultNumSet") {
            UserDefaults.standard.set(alignIndexDefault, forKey: alignKey)
            UserDefaults.standard.set(true, forKey: isHidden)
            UserDefaults.standard.set(false, forKey: hintToggleIsOn)
            UserDefaults.standard.set(0, forKey: numScore)
            UserDefaults.standard.set(0, forKey: buttonIndex)
            UserDefaults.standard.set(true, forKey: "defaultNumSet")
        }
        let tabBarVC = self.tabBarController as! UserScoreTabBarController
        userScore = tabBarVC.userScore
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Get new code in range 0 ... 1
        code = [Int(arc4random_uniform(6)), Int(arc4random_uniform(6)), Int(arc4random_uniform(6))]
        userScore.numScore = UserDefaults.standard.integer(forKey: numScore)
        hintToggler.isOn = UserDefaults.standard.bool(forKey: hintToggleIsOn)
        if hintToggler.isOn {
            hintLabel.isHidden = false
            UserDefaults.standard.set(false, forKey: isHidden)
        } else {
            hintLabel.isHidden = true
            UserDefaults.standard.set(true, forKey: isHidden)
        }
        hintLabel.textAlignment = alignArray[UserDefaults.standard.integer(forKey: alignKey)]
        hintLabel.text = "\(code[UserDefaults.standard.integer(forKey: alignKey)])"
        spinIndex.selectedSegmentIndex = UserDefaults.standard.integer(forKey: buttonIndex)
    }


}

