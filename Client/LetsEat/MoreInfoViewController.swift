//
//  MoreInfoViewController.swift
//  LetsEat
//
//  Created by thiet on 12/13/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class MoreInfoViewController: TransparentBarNavViewController {
    @IBOutlet weak var btnLanguage: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnRadioFemale: UIButton!
    @IBOutlet weak var btnRadioMale: UIButton!
    @IBOutlet weak var btnRadioUnknow: UIButton!
    var arrLocation:[String] = []
    var arrLanguage:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        hideButtonBack()
        
        arrLanguage = ["Tiếng Lào", "Tiếng Thái lan", "Vietnamese", "Tiếng Anh"]
        arrLocation = ["Lào", "Thái lan", "Việt Nam", "Anh"]
        btnLanguage.customDropdown(textname: "Tiếng Việt")
        btnLocation.customDropdown(textname: "Việt Nam")
        btnNext.radiusCustome(value: 5)
        // Do any additional setup after loading the view.
    }
    @IBAction func Location(_ sender: UIButton) {
        let LocaALangVC = sb.instantiateViewController(identifier: "Location_LanguageViewController") as! Location_LanguageViewController
        LocaALangVC.arrLocal_Lang = arrLocation
        LocaALangVC.didSelectText = { (textname) in
            sender.customDropdown(textname: textname)
        }
        self.navigationController?.pushViewController(LocaALangVC, animated: true)
    }
    @IBAction func Languge(_ sender: UIButton) {
        let LocaALangVC = sb.instantiateViewController(identifier: "Location_LanguageViewController") as! Location_LanguageViewController
        LocaALangVC.arrLocal_Lang = arrLanguage
        LocaALangVC.didSelectText = { (textname) in
            sender.customDropdown(textname: textname)
        }
        self.navigationController?.pushViewController(LocaALangVC, animated: true)
    }
    
    
    @IBAction func checkFemale(_ sender: UIButton) { //check button select Demo :))) radio maybe change button radio in table view
        sender.checkGender(radioUncheck1: btnRadioMale, radioUncheck2: btnRadioUnknow)
    }
    @IBAction func checkMale(_ sender: UIButton) {
        sender.checkGender(radioUncheck1: btnRadioFemale, radioUncheck2: btnRadioUnknow)
    }
    @IBAction func checkUnknow(_ sender: UIButton) {
        sender.checkGender(radioUncheck1: btnRadioMale, radioUncheck2: btnRadioFemale)
    }
    @IBAction func Next(_ sender: UIButton) {
        let favFoodVC = sb.instantiateViewController(identifier: "Favorite_FoodViewController") as! Favorite_FoodViewController
        
        self.navigationController?.pushViewController(favFoodVC, animated: true)
    }
    

}
