//
//  ProfileViewController.swift
//  LetsEat
//
//  Created by thiet on 12/24/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit
import Alamofire
class ProfileViewController: TransparentBarNavViewController {
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var btnChangeInfomation: UIButton!
    @IBOutlet weak var btnChangPassword: UIButton!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var btnCreatMenu: UIButton!
    @IBOutlet weak var btnFoodManager: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnChangPassword.radiusCustome(value: 5)
        btnCreatMenu.radiusCustome(value: 5)
        btnLogOut.radiusCustome(value: 5)
        btnHistory.radiusCustome(value: 5)
        btnFoodManager.radiusCustome(value: 5)
        btnChangeInfomation.radiusCustome(value: 5)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if user.lastname == ""{
            navigationItem.title = "Chào bạn"
        }
        else{
            navigationItem.title = "Chào \(user.lastname ?? "bạn")"
        }
    }
    
    @IBAction func LogOut(_ sender: UIButton) {
        let scence = self.view.window?.windowScene?.delegate as! SceneDelegate
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
        let changeInfomationVC = sb.instantiateViewController(identifier: "ChangeInfoUserViewController") as! ChangeInfoUserViewController
        self.navigationController?.pushViewController(changeInfomationVC, animated: true)
    }
    @IBAction func btnChangePassword(_ sender: Any) {
        let changePasswordVC = sb.instantiateViewController(identifier: "ChangePasswordUserViewController") as! ChangePasswordUserViewController
        self.navigationController?.pushViewController(changePasswordVC, animated: true)
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
