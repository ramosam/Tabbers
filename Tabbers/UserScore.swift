//
//  UserScore.swift
//  Tabbers
//
//  Created by Arcaurel on 2/22/20.
//  Copyright © 2020 Ramosam. All rights reserved.
//

import UIKit

class UserScore: NSObject {

    var numScore: Int = 0
    var colorScore: Int = 0
    
    func totalScore() -> Int {
        return numScore + colorScore
    }
    
}
