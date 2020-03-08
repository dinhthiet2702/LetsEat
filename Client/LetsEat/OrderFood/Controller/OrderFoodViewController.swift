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
    var hideBack:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewTotal.layer.cornerRadius = 10
        btnAcept.radiusCustome(value: 10)
        navigationItem.title = "Đơn hàng của bạn"
        ChangeNumberOfFoodsInCart()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        hideButtonBack(hideBack ?? true)
        RequestService.shared.request("http://localhost:3000/order/foods", .post, ["user_id":user.id!], URLEncodedFormParameterEncoder.default, nil, BaseResponseOrderFood.self) { (result, data, error) in
            guard let data = data as? BaseResponseOrderFood else {return}
            if data.result{
                self.arrFoods =  data.data!
            }
            self.ChangeNumberOfFoodsInCart()
            self.tableView.reloadData()
        }
    }
    @IBAction func AcceptBill(_ sender: UIButton) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let dateString = dateFormatter.string(from: currentDate)
        for i in self.arrFoods{
            self.parameter = [
                "namefood": i.namefood,
                "imgfood": i.imgfood,
                "price":i.price,
                "amount":i.amount,
                "user_id":user.id!,
                "dateorder":dateString
            ]
            RequestService.shared.request("http://localhost:3000/addhistoryorderfoods", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponseOrder.self) { (result, dataadd, err) in
                guard let dataadd = dataadd as? BaseResponseOrder else {return}
                if dataadd.result{
                    print("them thanh cong")
                }
            }
        }
        RequestService.shared.request("http://localhost:3000/deletefoodsorder", .post, ["user_id":user.id!], URLEncodedFormParameterEncoder.default, nil, BaseResponseOrder.self) { (result, datadel, err) in
            guard let datadel = datadel as? BaseResponseOrder else {return}
            if datadel.result{
                let alert = UIAlertController(title: "Thông báo", message: datadel.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                    for controller in self.navigationController!.viewControllers as Array {
                        if controller.isKind(of: MainViewController.self) {
                            self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
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
            if amount >= 0{
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
                                    self.arrFoods.remove(at: indexPath.row)
                                }
                                self.tableView.reloadData()
                            }
                        }
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
                    self.arrFoods.remove(at: indexPath.row)
                }
                self.tableView.reloadData()
            }
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
                    else{
                        let DeliveryVC = sb.instantiateViewController(identifier: "DeliveryViewController") as! DeliveryViewController
                        self.navigationController?.pushViewController(DeliveryVC, animated: true)
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
