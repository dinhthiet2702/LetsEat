//
//  MenuFoodViewController.swift
//  LetsEat
//
//  Created by thiet on 1/3/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit

class MenuFoodViewController: TransparentBarNavViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnBill:UIButton!
    @IBOutlet weak var viewBill: UIView!
    var pushView:(()-> Void)! = nil
    var titleView:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CustomBackItem()
        navigationItem.title = titleView
        btnBill.radiusCustome(value: 10)
    }

}
extension MenuFoodViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        default:
            return 3
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Món chính"
        default:
            return "Món phụ"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodsCell", for: indexPath) as! FoodsCell
            cell.btnAdd.radiusCustome(value: 5)
            cell.didadd = {
                
                cell.viewAmout.isHidden = false
                cell.btnAdd.isHidden = true
            }
            cell.didChangeAmount = { (amount) in
                cell.tfAmount.text = String(amount)
                if (amount <= 0){
                    cell.viewAmout.isHidden = true
                    cell.btnAdd.isHidden = false
                    UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                        self.viewBill.alpha = 0
                    }) { (_) in
                        self.viewBill.isHidden = true
                    }
                }
                else{
                    UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
                        self.viewBill.alpha = 1
                    }) { (_) in
                        self.viewBill.isHidden = false
                    }
                }
                print(amount)
                self.tableView.reloadData()
                
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodsCell2", for: indexPath) as! FoodsCell2
            cell.didadd = {
                cell.viewAmout.isHidden = false
                cell.btnAdd.isHidden = true
            }
            cell.didChangeAmount = { (amount) in
                cell.tfAmount.text = String(amount)
                if (amount <= 0){
                    cell.viewAmout.isHidden = true
                    cell.btnAdd.isHidden = false
                }
                print(amount)
                self.tableView.reloadData()
                
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        default:
            return 150
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("\(indexPath.row)")
        default:
            print("\(indexPath.row)")
        }
    }
    
}
