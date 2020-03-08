//
//  DetailFoodsMenuFoodViewController.swift
//  LetsEat
//
//  Created by thiet on 3/6/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit
import Alamofire
class DetailFoodsMenuFoodViewController: TransparentBarNavViewController {
    var menufood_id:String!
    var arrFoods:[Foods] = []
    var parameter:[String:String]!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(menufood_id ?? "0")
        CustomBackItem()
        navigationItem.title = "Quản lý món ăn của bạn"
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        RequestService.shared.request("http://localhost:3000/delivery/menufood", .post, ["menufood_id":menufood_id], URLEncodedFormParameterEncoder.default, nil, BaseResposeFoods.self) { (result, data, err) in
            guard let data = data as? BaseResposeFoods else {return}
            if data.result{
                self.arrFoods = data.data!
            }
            self.tableView.reloadData()
        }
    }
}
extension DetailFoodsMenuFoodViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFoods.count > 0 ? self.arrFoods.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodsMenuFoodCell", for: indexPath) as! FoodsMenuFoodCell
        if arrFoods.count > 0{
            cell.viewFoods.isHidden = false
            cell.viewNonFoods.isHidden = true
            cell.bindData(foods: arrFoods[indexPath.row])
            cell.imgFood.layer.cornerRadius = 10
            cell.didRemove = {
                
                let alert:UIAlertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn xoá món ăn này?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Có", style: .default, handler: { (_) in
                    self.parameter = [
                        "imgname":self.arrFoods[indexPath.row].imgfood!,
                        "accpectEditImage":"true"
                    ]
                    RequestService.shared.request("http://localhost:3000/removephoto", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, json, err) in
                        guard let json = json as? BaseResponse else {return}
                        if json.result{
                            RequestService.shared.request("http://localhost:3000/getmenu/didupload/foods/delete", .post, ["id":self.arrFoods[indexPath.row].id!], URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, data, err) in
                                guard let data = data as? BaseResponse else {return}
                                if data.result{
                                    let alert1:UIAlertController = UIAlertController(title: "Thông báo", message: data.message, preferredStyle: .alert)
                                    alert1.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                                        self.arrFoods.remove(at: indexPath.row)
                                        self.tableView.reloadData()
                                    }))
                                    self.present(alert1, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                }))
                alert.addAction(UIAlertAction(title: "Không", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            cell.viewFoods.isHidden = true
            cell.viewNonFoods.isHidden = false
            cell.btnUploadFood.radiusCustome(value: 10)
            cell.didUploadFood = {
                let UploadFoodVC = sb.instantiateViewController(identifier: "FoodsSaleViewController") as! FoodsSaleViewController
                UploadFoodVC.id = self.menufood_id
                self.navigationController?.pushViewController(UploadFoodVC, animated: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrFoods.count > 0{
            let EditFoodVC = sb.instantiateViewController(identifier: "EditFoodViewController") as! EditFoodViewController
            EditFoodVC.food = self.arrFoods[indexPath.row]
            self.navigationController?.pushViewController(EditFoodVC, animated: true)
        }
    }
}
