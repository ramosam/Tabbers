//
//  FirstViewController.swift
//  Tabbers
//
//  Created by Arcaurel on 2/21/20.
//  Copyright © 2020 Ramosam. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let numberOptions = ["0", "1", "2", "3", "4", "5"]

    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numberOptions[row]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker1.dataSource = (numberOptions as! UIPickerViewDataSource)
        picker2.dataSource = (numberOptions as! UIPickerViewDataSource)
        
    }


}

