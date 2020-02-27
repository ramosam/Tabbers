//
//  SecondViewController.swift
//  Tabbers
//
//  Created by Arcaurel on 2/21/20.
//  Copyright © 2020 Ramosam. All rights reserved.
//

import UIKit

// Color Matcher
class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    private let colorOptions = [UIColor.red, UIColor.blue, UIColor.yellow, UIColor.green, UIColor.purple, UIColor.orange]
    private let colorOptionNames = ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"]
    private let matchText = "Match Me"
    private let spinnerColors = [UIColor.purple, UIColor.green, UIColor.orange]
    private var masterColor = Int(arc4random_uniform(6))
    var userScore = UserScore()
    // Lab 8
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var colorPicker: UIPickerView!
    
    @IBOutlet weak var matchColorBox: UITextView!
    
    @IBAction func changeMasterColor(_ sender: Any) {
        masterColor = Int(arc4random_uniform(6))
        matchColorBox.backgroundColor = colorOptions[masterColor]
    }
    
    @IBAction func changeMatchColorBoxText(_ sender: Any) {
        let segmentedControl = sender as! UISegmentedControl
        if segmentedControl.selectedSegmentIndex == 0 {
            matchColorBox.text = ""
            defaults.set("", forKey: matchText)
        } else {
            matchColorBox.text = matchText
            defaults.set(matchText, forKey: matchText)
        }
    }
    
    @IBAction func spinnerColorControl(_ sender: Any) {
        let segmentedControl = sender as! UISegmentedControl
        if segmentedControl.selectedSegmentIndex == 0 {
            colorPicker.backgroundColor = spinnerColors[0]
            defaults.set(0, forKey: "spinnerColorIndex")
        } else if segmentedControl.selectedSegmentIndex == 1 {
            colorPicker.backgroundColor = spinnerColors[1]
            defaults.set(1, forKey: "spinnerColorIndex")
        } else {
            colorPicker.backgroundColor = spinnerColors[2]
            defaults.set(2, forKey: "spinnerColorIndex")
        }
    }
    
    
    
    @IBAction func matchButton(_ sender: Any) {
        switch masterColor {
        case 0:
            if (colorPicker.selectedRow(inComponent: 0) == 0 && colorPicker.selectedRow(inComponent: 1) == 0) {
                userScore.colorScore += 1
                showAlert()
            }
            
        case 1:
            if (colorPicker.selectedRow(inComponent: 0) == 1 && colorPicker.selectedRow(inComponent: 1) == 1) {
                userScore.colorScore += 1
                showAlert()
            }
            
        case 2:
            if (colorPicker.selectedRow(inComponent: 0) == 2 && colorPicker.selectedRow(inComponent: 1) == 2) {
                userScore.colorScore += 1
                showAlert()
            }
        case 3:
            if ((colorPicker.selectedRow(inComponent: 0) == 1 && colorPicker.selectedRow(inComponent: 1) == 2) || (colorPicker.selectedRow(inComponent: 0) == 2 && colorPicker.selectedRow(inComponent: 1) == 1)) {
                userScore.colorScore += 1
                showAlert()
            }
        case 4:
            if ((colorPicker.selectedRow(inComponent: 0) == 1 && colorPicker.selectedRow(inComponent: 1) == 0) || (colorPicker.selectedRow(inComponent: 0) == 0 && colorPicker.selectedRow(inComponent: 1) == 1)) {
                userScore.colorScore += 1
                showAlert()
            }
        case 5:
            if ((colorPicker.selectedRow(inComponent: 0) == 0 && colorPicker.selectedRow(inComponent: 1) == 2) || (colorPicker.selectedRow(inComponent: 0) == 2 && colorPicker.selectedRow(inComponent: 1) == 0)) {
                userScore.colorScore += 1
                showAlert()
            }
        default:
            userScore.colorScore += 0
        }
        defaults.set(userScore.colorScore, forKey: "colScore")
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Success", message: "You matched the color!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Awesome", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Player has to match red, blue, and yellow
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorOptionNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: colorOptionNames[row], attributes: [
            NSAttributedString.Key.foregroundColor: colorOptions[row]
        ])
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tabBarVC = self.tabBarController as! UserScoreTabBarController
        userScore = tabBarVC.userScore
        matchColorBox.text = defaults.string(forKey: matchText)
        colorPicker.backgroundColor = spinnerColors[defaults.integer(forKey: "spinnerColorIndex")]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        matchColorBox.backgroundColor = colorOptions[masterColor]
        matchColorBox.text = defaults.string(forKey: matchText)
        colorPicker.backgroundColor = spinnerColors[defaults.integer(forKey: "spinnerColorIndex")]
    }


    
}

