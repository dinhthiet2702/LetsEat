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
    var arrMenuFood:MenuFood!
    var arrkindFood:[kindFood] = []
    var arrFood:[Foods] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CustomBackItem()
        navigationItem.title = arrMenuFood.name
        btnBill.radiusCustome(value: 10)
        self.arrkindFood = arrMenuFood.kindFood
        ChangeAmountFoods()
        
    }
    func ChangeAmountFoods(){
        var total:Int = 0
        for i in self.arrkindFood{
            for j in i.food {
                total += j.amount
            }
        }
        if total <= 0 {
            self.viewBill.isHidden = true
        }
        else{
            self.viewBill.isHidden = false
        }
        
    }
    @IBAction func btn_Bill(_ sender: UIButton) {
        let OrderVC = sb.instantiateViewController(withIdentifier: "OrderFoodViewController") as! OrderFoodViewController
        for i in self.arrkindFood{
            for j in i.food {
                if j.amount > 0{
                    OrderVC.arrFood.append(j)
                }
            }
        }
        self.navigationController?.pushViewController(OrderVC, animated: true)
    }
    
    

}
extension MenuFoodViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.arrkindFood[section].food.count
        default:
            return self.arrkindFood[section].food.count
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return self.arrkindFood[section].name
        default:
            return self.arrkindFood[section].name
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodsCell", for: indexPath) as! FoodsCell
            cell.btnAdd.radiusCustome(value: 5)
            cell.img.layer.cornerRadius = 5
            cell.bindData(food: self.arrkindFood[indexPath.section].food[indexPath.row])
            cell.didadd = {
                cell.viewAmout.isHidden = false
                cell.btnAdd.isHidden = true
            }
            
            cell.didChangeAmount = { (amount) in
                self.arrkindFood[indexPath.section].food[indexPath.row].amount = amount
                self.arrFood.append(self.arrkindFood[indexPath.section].food[indexPath.row])
                self.ChangeAmountFoods()
                if (amount <= 0){
                    cell.viewAmout.isHidden = true
                    cell.btnAdd.isHidden = false
                }
                self.tableView.reloadData()
                
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodsCell2", for: indexPath) as! FoodsCell2
            cell.btnAdd.radiusCustome(value: 5)
            cell.img.layer.cornerRadius = 5
            cell.bindData(food: self.arrkindFood[indexPath.section].food[indexPath.row])
            cell.didadd = {
                cell.viewAmout.isHidden = false
                cell.btnAdd.isHidden = true
            }
            cell.didChangeAmount = { (amount) in
                self.arrkindFood[indexPath.section].food[indexPath.row].amount = amount
                self.ChangeAmountFoods()
                if (amount <= 0){
                    cell.viewAmout.isHidden = true
                    cell.btnAdd.isHidden = false
                }
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
    
}