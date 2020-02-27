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
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var winLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tabBarVC = self.tabBarController as! UserScoreTabBarController
        userScore = tabBarVC.userScore
        
    }

    override func viewWillAppear(_ animated: Bool) {
        // using subclass container
//        winLabel.text = "\(userScore.totalScore())"
        
        // using UserDefaults
        // get both view's scores
        let combinedScore = defaults.integer(forKey: "numScore") + defaults.integer(forKey: "colScore")
        winLabel.text = "\(combinedScore)"
    }
    
}
