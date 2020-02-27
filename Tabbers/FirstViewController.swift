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
    
    @IBOutlet weak var picker1: UIPickerView!
    var userScore = UserScore()
    // Lab 8
    var defaults = UserDefaults.standard
    
    
    
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
    }


}

