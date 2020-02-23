//
//  MenuFoodViewController.swift
//  LetsEat
//
//  Created by thiet on 1/3/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit
import Alamofire

class MenuFoodViewController: TransparentBarNavViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnBill:UIButton!
    @IBOutlet weak var viewBill: UIView!
    var pushView:(()-> Void)! = nil
    var arrMenuFood:MenuFood!
    var arrkindFood:[kindFood]!
    var arrFoodMain:[Foods] = []
    var arrFoodSide:[Foods] = []
    var arrFoods:[Foods] = []
    var parameter:[String:String]! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CustomBackItem()
        navigationItem.title = arrMenuFood.name
        btnBill.radiusCustome(value: 10)
        RequestService.shared.request("http://localhost:3000/delivery/menufood/foods", .post, ["id":arrkindFood[0].id], URLEncodedFormParameterEncoder.default, nil, BaseResposeFoods.self) { (result, data, err) in
            guard let data = data as? BaseResposeFoods else {return}
            
                self.arrFoodMain = data.data!
            self.tableView.reloadData()
        }
        RequestService.shared.request("http://localhost:3000/delivery/menufood/foods", .post, ["id":arrkindFood[1].id], URLEncodedFormParameterEncoder.default, nil, BaseResposeFoods.self) { (result, data, err) in
            guard let data = data as? BaseResposeFoods else {return}
            
                self.arrFoodSide = data.data!
            self.tableView.reloadData()
        }
        ChangeAmountFoods()
        
    }
    func ChangeAmountFoods(){
        var total:Int = 0
        var amountFoodMain:Int = 0
        var amountFoodSide:Int  = 0
        for i in self.arrFoodMain{
            amountFoodMain += Int(i.amount)!
        }
        for i in self.arrFoodSide{
            amountFoodSide += Int(i.amount)!
        }
        total = amountFoodMain + amountFoodSide
        if total <= 0 {
            self.viewBill.isHidden = true
        }
        else{
            self.viewBill.isHidden = false
        }

    }
    @IBAction func btn_Bill(_ sender: UIButton) {
        let OrderVC = sb.instantiateViewController(withIdentifier: "OrderFoodViewController") as! OrderFoodViewController
        for i in self.arrFoodMain{
            if Int(i.amount)! > 0
            {
                self.parameter = [
                    "namefood": i.namefood,
                    "imgfood": i.imgfood,
                    "price":i.price,
                    "amount":i.amount
                ]
                RequestService.shared.request("http://localhost:3000/delivery/menufood/orderfoods", .post, parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponseOrder.self) { (result, data, err) in
                    guard let data = data as? BaseResponseOrder else {return}
                    if data.result{
                        print("OK")
                    }
                }
            }
        }
        for i in self.arrFoodSide{
            if Int(i.amount)! > 0
            {
                OrderVC.arrFoods.append(i)
                 self.parameter = [
                        "namefood": i.namefood,
                        "imgfood": i.imgfood,
                        "price":i.price,
                        "amount":i.amount
                    ]
                RequestService.shared.request("http://localhost:3000/delivery/menufood/orderfood", .post, parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponseOrder.self) { (result, data, err) in
                    guard let data = data as? BaseResponseOrder else {return}
                    if data.result{
                        print("OK1")
                    }
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
            return arrFoodMain.count
        default:
            return arrFoodSide.count
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
            cell.bindData(food: self.arrFoodMain[indexPath.row])
            cell.didadd = {
                cell.viewAmout.isHidden = false
                cell.btnAdd.isHidden = true
            }
            
            cell.didChangeAmount = { (amount) in
                self.parameter = [
                    "id":self.arrFoodMain[indexPath.row].id,
                    "amount":String(amount)
                ]
                RequestService.shared.request("http://localhost:3000/delivery/menufood/foods/changeamount", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponseFoodsAmount.self) { (result, data, err) in
                    guard let data = data as? BaseResponseFoodsAmount else {return}
                    if data.result{
                        self.arrFoodMain[indexPath.row].amount = String(amount)
                        self.ChangeAmountFoods()
                        if (amount <= 0){
                            cell.viewAmout.isHidden = true
                            cell.btnAdd.isHidden = false
                        }
                        self.tableView.reloadData()
                    }
                }
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodsCell2", for: indexPath) as! FoodsCell2
            cell.btnAdd.radiusCustome(value: 5)
            cell.img.layer.cornerRadius = 5
            cell.bindData(food: self.arrFoodSide[indexPath.row])
            cell.didadd = {
                cell.viewAmout.isHidden = false
                cell.btnAdd.isHidden = true
            }
            cell.didChangeAmount = { (amount) in
                self.parameter = [
                    "id":self.arrFoodSide[indexPath.row].id,
                    "amount":String(amount)
                ]
                RequestService.shared.request("http://localhost:3000/delivery/menufood/foods/changeamount", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponseFoodsAmount.self) { (result, data, err) in
                    guard let data = data as? BaseResponseFoodsAmount else {return}
                    if data.result{
                        self.arrFoodSide[indexPath.row].amount = String(amount)
                        self.ChangeAmountFoods()
                        if (amount <= 0){
                            cell.viewAmout.isHidden = true
                            cell.btnAdd.isHidden = false
                        }
                        self.tableView.reloadData()
                    }
                }
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
