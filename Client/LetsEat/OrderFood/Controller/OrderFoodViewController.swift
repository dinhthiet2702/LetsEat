//
//  OrderFoodViewController.swift
//  LetsEat
//
//  Created by thiet on 2/15/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit
import Alamofire

class OrderFoodViewController: TransparentBarNavViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAcept: UIButton!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var viewTotal: UIView!
    var parameter:[String:String]! = nil
    var arrFoods:[Foods] = []
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
    override func viewDidAppear(_ animated: Bool) {
        RequestService.shared.request("http://localhost:3000/order/foods", .get, nil, URLEncodedFormParameterEncoder.default, nil, BaseResponseOrderFood.self) { (result, data, error) in
            guard let data = data as? BaseResponseOrderFood else {return}
            if data.result{
                self.arrFoods =  data.data!
            }
            self.ChangeNumberOfFoodsInCart()
            self.tableView.reloadData()
        }
    }
    func ChangeNumberOfFoodsInCart(){
        var total:Int = 0
        for i in self.arrFoods{
            total += Int(i.amount)! * Int(i.price)!
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
        return self.arrFoods.count > 0 ? self.arrFoods.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCellOrder", for: indexPath) as! FoodCellOrder
        cell.didChangeAmount = { (amount) in
            self.parameter = [
                "id":self.arrFoods[indexPath.row].id,
                "amount":String(amount)
            ]
            RequestService.shared.request("http://localhost:3000/order/foods/changeamount", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponseFoodsAmount.self) { (result, data, err) in
                guard let data = data as? BaseResponseFoodsAmount else {return}
                if data.result{
                    self.arrFoods[indexPath.row].amount = String(amount)
                    self.ChangeNumberOfFoodsInCart()
                    self.tableView.reloadData()
                    if (amount <= 0){
                        self.parameter = [
                            "id":self.arrFoods[indexPath.row].id,
                        ]
                        RequestService.shared.request("http://localhost:3000/order/foods/delete", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponseFoodsAmount.self) { (result, data, err) in
                            guard let data = data as? BaseResponseFoodsAmount else {return}
                            if data.result{
                                self.ChangeNumberOfFoodsInCart()
                                self.viewDidAppear(true)
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
        cell.didRemove = {
            self.parameter = [
                "id":self.arrFoods[indexPath.row].id,
            ]
            RequestService.shared.request("http://localhost:3000/order/foods/delete", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponseFoodsAmount.self) { (result, data, err) in
                guard let data = data as? BaseResponseFoodsAmount else {return}
                if data.result{
                    self.ChangeNumberOfFoodsInCart()
                    self.viewDidAppear(true)
                }
            }
            self.tableView.reloadData()
           
        }
        if self.arrFoods.count > 0 {
            cell.viewFood.isHidden = false
            cell.viewnonFood.isHidden = true
            cell.bindData(food: arrFoods[indexPath.row])
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
