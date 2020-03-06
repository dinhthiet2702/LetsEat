//
//  FoodManagerViewController.swift
//  LetsEat
//
//  Created by thiet on 3/4/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit
import Alamofire
class FoodManagerViewController: TransparentBarNavViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrMenuFoodUser:[MenuFood] = []
    var parameter:[String:String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomBackItem()
        navigationItem.title = "Menu của bạn"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        RequestService.shared.request("http://localhost:3000/getmenu/didupload", .post, ["user_id":user.id!], URLEncodedFormParameterEncoder.default, nil, BaseResposeMenuFood.self) { (result, data, err) in
            guard let data = data as? BaseResposeMenuFood else {return}
            if data.result{
                self.arrMenuFoodUser = data.data!
            }
            self.tableView.reloadData()
        }
    }

}
extension FoodManagerViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMenuFoodUser.count > 0 ? self.arrMenuFoodUser.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuFoodManagerCell", for: indexPath) as! MenuFoodManagerCell
        if self.arrMenuFoodUser.count > 0{
            cell.viewNonMenuFood.isHidden = true
            cell.viewMenuFoodUser.isHidden = false
            cell.imgMenufood.layer.cornerRadius = 10
            cell.binData(mf: arrMenuFoodUser[indexPath.row])
            cell.didRemove = {
                self.parameter = [
                    "imgname":self.arrMenuFoodUser[indexPath.row].img!,
                    "accpectEditImage":"true"
                ]
                let alert:UIAlertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn xoá menu này?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Có", style: .default, handler: { (_) in
                    RequestService.shared.request("http://localhost:3000/removephoto", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, json, err) in
                        guard let json = json as? BaseResponse else {return}
                        if json.result{
                            RequestService.shared.request("http://localhost:3000/getmenu/didupload/remove/removefoods", .post, ["id":self.arrMenuFoodUser[indexPath.row].id!], URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, data, err) in
                                guard let data = data as? BaseResponse else {return}
                                if data.result{
                                    RequestService.shared.request("http://localhost:3000/getmenu/didupload/remove", .post, ["id":self.arrMenuFoodUser[indexPath.row].id!], URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, delete, err) in
                                            guard let delete = delete as? BaseResponse else {return}
                                            if delete.result{
                                                let alert1:UIAlertController = UIAlertController(title: "Thông báo", message: data.message, preferredStyle: .alert)
                                                alert1.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                                                    self.arrMenuFoodUser.remove(at: indexPath.row)
                                                    self.tableView.reloadData()
                                                }))
                                                self.present(alert1, animated: true, completion: nil)
                                            }
                                        }
                                }
                            }
                        }
                    }
                }))
                alert.addAction(UIAlertAction(title: "Không", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            cell.didEdit = {
                let EditMenuFood = sb.instantiateViewController(identifier: "EditMenuFoodViewController") as! EditMenuFoodViewController
                EditMenuFood.menuFood = self.arrMenuFoodUser[indexPath.row]
                self.navigationController?.pushViewController(EditMenuFood, animated: true)
            }
        }
        else{
            cell.viewNonMenuFood.isHidden = false
            cell.viewMenuFoodUser.isHidden = true
            cell.btndidUpload.radiusCustome(value: 5)
            cell.didUploadMenu = {
                let UploadVC = sb.instantiateViewController(identifier: "ForSaleViewController") as! ForSaleViewController
                self.navigationController?.pushViewController(UploadVC, animated: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrMenuFoodUser.count > 0{
            let detailFoodsMenuFoodVC = sb.instantiateViewController(identifier: "DetailFoodsMenuFoodViewController") as! DetailFoodsMenuFoodViewController
            detailFoodsMenuFoodVC.menufood_id = arrMenuFoodUser[indexPath.row].id!
            self.navigationController?.pushViewController(detailFoodsMenuFoodVC, animated: true)
        }
    }
}
