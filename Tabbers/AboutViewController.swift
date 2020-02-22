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
    @IBOutlet weak var winLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tabBarVC = self.tabBarController as! UserScoreTabBarController
        userScore = tabBarVC.userScore
        
    }

    override func viewWillAppear(_ animated: Bool) {
        winLabel.text = "\(userScore.totalScore())"
    }
    
}
