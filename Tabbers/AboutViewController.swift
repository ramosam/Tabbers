//
//  AboutViewController.swift
//  Tabbers
//
//  Created by Arcaurel on 2/21/20.
//  Copyright © 2020 Ramosam. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    var userScore = UserScore()
    // Lab 8
    
    @IBOutlet weak var winLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tabBarVC = self.tabBarController as! UserScoreTabBarController
        userScore = tabBarVC.userScore
        let placeholder = UserDefaults.standard.string(forKey: "name")
        nameLabel.text = placeholder == "" ? "" : "Good job \(placeholder ?? "")!"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let combinedScore = UserDefaults.standard.integer(forKey: "numScore") + UserDefaults.standard.integer(forKey: "colScore")
        winLabel.text = "\(combinedScore)"
    }


    
}
