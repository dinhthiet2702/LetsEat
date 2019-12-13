//
//  MoreInfoViewController.swift
//  LetsEat
//
//  Created by thiet on 12/13/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {
    var languge:String = ""
    var location:String = ""
    @IBOutlet weak var btnLanguage: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        languge = "Tiếng Việt"
        location = "Việt Nam"
        btnLanguage.customDropdown(textname: languge)
        btnLocation.customDropdown(textname: location)
        btnNext.radiusCustome(value: 5)
        // Do any additional setup after loading the view.
    }
    @IBAction func checkFemale(_ sender: UIButton) { //check button select Demo :))) radio maybe change button radio in table view
        if sender.isSelected{
            sender.isSelected = false
        }
        else{
            sender.isSelected = true
        }
    }
    @IBAction func checkMale(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
            print(sender.isSelected)
        }
        else{
            sender.isSelected = true
            print(sender.isSelected)
        }
    }
    @IBAction func checkNoGender(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        }
        else{
            sender.isSelected = true
        }
    }
    

}
