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
    private let matchKey = "matchKey"
    private let hideMatchTextToggleIndex = 0
    private let hideMatchText = "hideMatchText"
    private let colScore = "colScore"
    private let colScoreDefault = 0
    private let spinValue = 0
    private let spinnerColorIndex = "spinnerColorIndex"
    
    private let spinnerColors = [UIColor.purple, UIColor.green, UIColor.orange]
    private var masterColor = Int(arc4random_uniform(6))
    var userScore = UserScore()
    // Lab 8
    
    
    @IBOutlet weak var hideMatchTextToggle: UISegmentedControl!
    @IBOutlet weak var colorPickerControl: UISegmentedControl!
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
            UserDefaults.standard.set("", forKey: matchKey)
            UserDefaults.standard.set(0, forKey: hideMatchText)
        } else {
            matchColorBox.text = matchText
            UserDefaults.standard.set(matchText, forKey: matchKey)
            UserDefaults.standard.set(1, forKey: hideMatchText)
        }
    }
    
    @IBAction func spinnerColorControl(_ sender: Any) {
        let segmentedControl = sender as! UISegmentedControl
        if segmentedControl.selectedSegmentIndex == 0 {
            colorPicker.backgroundColor = spinnerColors[0]
            UserDefaults.standard.set(0, forKey: spinnerColorIndex)
        } else if segmentedControl.selectedSegmentIndex == 1 {
            colorPicker.backgroundColor = spinnerColors[1]
            UserDefaults.standard.set(1, forKey: spinnerColorIndex)
        } else {
            colorPicker.backgroundColor = spinnerColors[2]
            UserDefaults.standard.set(2, forKey: spinnerColorIndex)
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
        UserDefaults.standard.set(userScore.colorScore, forKey: colScore)
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
        if !UserDefaults.standard.bool(forKey: "defaultColorSet") {
            UserDefaults.standard.set(spinValue, forKey: spinnerColorIndex)
            UserDefaults.standard.set(matchText, forKey: matchKey)
            UserDefaults.standard.set(colScoreDefault, forKey: colScore)
            UserDefaults.standard.set(hideMatchTextToggleIndex, forKey: hideMatchText)
            UserDefaults.standard.set(true, forKey: "defaultColorSet")
        }

        let tabBarVC = self.tabBarController as! UserScoreTabBarController
        userScore = tabBarVC.userScore
        matchColorBox.text = UserDefaults.standard.string(forKey: matchKey)
        colorPicker.backgroundColor = spinnerColors[UserDefaults.standard.integer(forKey: spinnerColorIndex)]
    }
    

    override func viewDidAppear(_ animated: Bool) {
        masterColor = Int(arc4random_uniform(6))
        matchColorBox.backgroundColor = colorOptions[masterColor]
        userScore.colorScore = UserDefaults.standard.integer(forKey: colScore)
        colorPicker.backgroundColor = spinnerColors[UserDefaults.standard.integer(forKey: spinnerColorIndex)]
        hideMatchTextToggle.selectedSegmentIndex = UserDefaults.standard.integer(forKey: hideMatchText)
        matchColorBox.text = UserDefaults.standard.string(forKey: matchKey)
        colorPickerControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: spinnerColorIndex)
    }
    
}

