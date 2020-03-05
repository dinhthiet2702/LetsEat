//
//  ProfileViewController.swift
//  LetsEat
//
//  Created by thiet on 12/24/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit
import Alamofire

var user:User!

class ProfileViewController: TransparentBarNavViewController {
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var btnUploadFood: UIButton!
    @IBOutlet weak var btnFoodManager: UIButton!
    @IBOutlet weak var btnChangeInfomation: UIButton!
    @IBOutlet weak var btnChangPassword: UIButton!
    @IBOutlet weak var btnLogOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LogOut(_ sender: UIButton) {
        let scence = self.view.window?.windowScene?.delegate as! SceneDelegate
        scence.logOut()
        UserDefaults.standard.removeObject(forKey: "token")
        scence.logOut()
    }
    @IBAction func UploadFoods(_ sender: Any) {
        let forSaleVC = sb.instantiateViewController(identifier: "ForSaleViewController") as! ForSaleViewController
        
        self.navigationController?.pushViewController(forSaleVC, animated: true)
    }
    @IBAction func History(_ sender: UIButton) {
        let historyVC = sb.instantiateViewController(identifier: "HistoryFoodViewController") as! HistoryFoodViewController
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
    @IBAction func foodManager(_ sender: Any) {
        let foodsmanagerVC = sb.instantiateViewController(identifier: "FoodManagerViewController") as! FoodManagerViewController
        self.navigationController?.pushViewController(foodsmanagerVC, animated: true)
    }
    @IBAction func changeInfomation(_ sender: Any) {
    }
    @IBAction func btnChangePassword(_ sender: Any) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
