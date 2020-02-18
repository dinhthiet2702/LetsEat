//
//  OrderFoodViewController.swift
//  LetsEat
//
//  Created by thiet on 2/15/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit

class OrderFoodViewController: TransparentBarNavViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAcept: UIButton!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var viewTotal: UIView!
    
    var arrFood:[Foods] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewTotal.layer.cornerRadius = 10
        btnAcept.radiusCustome(value: 10)
        CustomBackItem()
        navigationItem.title = "Đơn hàng của bạn"
        ChangeNumberOfFoodsInCart()
    }
    func ChangeNumberOfFoodsInCart(){
        var total:Int = 0
        for i in self.arrFood{
            total += i.amount * i.price
        }
        if total <= 0 {
            self.viewTotal.isHidden = true
        }
        else{
            self.viewTotal.isHidden = false
            lbTotal.text = String("\(total) đ")
        }
        
    }
    
}
extension OrderFoodViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFood.count > 0 ? arrFood.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCellOrder", for: indexPath) as! FoodCellOrder
        cell.didChangeAmount = { (amount) in
            self.arrFood[indexPath.row].amount = amount
            self.ChangeNumberOfFoodsInCart()
            if (amount <= 0){
                self.arrFood.remove(at: indexPath.row)
            }
            self.tableView.reloadData()
            
        }
        cell.didRemove = {
            self.arrFood.remove(at: indexPath.row)
            self.ChangeNumberOfFoodsInCart()
            self.tableView.reloadData()
        }
        if self.arrFood.count > 0 {
            cell.viewFood.isHidden = false
            cell.viewnonFood.isHidden = true
            cell.bindData(food: arrFood[indexPath.row])
            cell.img.layer.cornerRadius = 5
        }
        else{
            cell.viewFood.isHidden = true
            cell.viewnonFood.isHidden = false
            cell.btn_NonFood.radiusCustome(value: 10)
            cell.didNonFood = {
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: DeliveryViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            }
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
