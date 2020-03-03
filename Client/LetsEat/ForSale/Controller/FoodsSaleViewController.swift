//
//  FoodsSaleViewController.swift
//  LetsEat
//
//  Created by thiet on 2/25/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit
import Alamofire
import DKImagePickerController

class FoodsSaleViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var arrFood:[String] = []
    var total:Int = 0
    var id:String!
    var arrImages:[UIImage] = []
    var parameter:[String:String]!
    let pickerController = DKImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        let segmentBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
            navigationItem.rightBarButtonItem = segmentBarItem
        
        // Do any additional setup after loading the view.
    }
    @objc func add() {
        total += 1
        self.arrFood.append(String(total))
        self.tableView.reloadData()
    }

}
extension FoodsSaleViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodsSaleCell", for: indexPath) as! FoodsSaleCell
        cell.imgfood.layer.cornerRadius = 10
        cell.didChoose = {
            self.pickerController.maxSelectableCount = 1
            self.pickerController.showsCancelButton = true
            self.pickerController.didSelectAssets = { (assets: [DKAsset]) in
            var images = [UIImage]()
                assets.forEach { (img) in
                    img.fetchImage(with: CGSize(width: 300, height: 300)) { (image, info) in
                        if let image = image {
                            images.append(image)
                            cell.imgfood.image = image
                        }
                    }
                }
                self.arrImages = images
                self.tableView.reloadData()
            }
            self.present(self.pickerController, animated: true) {}
        }
        cell.didMonChinh = { (sender) in
            sender.isSelected = true
            cell.btnMonPhu.isSelected = false
        }
        cell.didMonPhu = { (sender) in
            sender.isSelected = true
            cell.btnMonChinh.isSelected = false
        }
        cell.didRemove = {
            self.arrFood.remove(at: indexPath.row)
            self.tableView.reloadData()
            
        }
        cell.didAddFood = {
            if cell.namefood.text!.count > 0 && cell.price.text!.count > 0 {
                var dataImages : [Dictionary<String, Any>] = []
                self.arrImages.forEach { (img) in
                // resize image
                let convertImage = img.jpegData(compressionQuality: 0)
                           dataImages.append(["key" : "photo",
                                              "value" : convertImage!])
                       }
                RequestService.shared.upload("http://localhost:3000/photo", nil, ArrayResponse.self, dataImages) { (result, json, error) in
                    guard let json = json as? ArrayResponse else {return}
                    if json.result == true{
                        if (cell.btnMonChinh.isSelected == false) && (cell.btnMonPhu.isSelected == false) {
                            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa chọn loại món ăn", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else if cell.btnMonChinh.isSelected == true{
                            self.parameter = [
                                "namefood":cell.namefood.text!,
                                "imgfood":json.data.originalname!,
                                "price":cell.price.text!,
                                "amount":"0",
                                "menufood_id":self.id!,
                                "namekindfood":"MÓN CHÍNH"
                            ]
                        }
                        else{
                            self.parameter = [
                                "namefood":cell.namefood.text!,
                                "imgfood":json.data.originalname!,
                                "price":cell.price.text!,
                                "amount":"0",
                                "menufood_id":self.id!,
                                "namekindfood":"MÓN PHỤ"
                            ]
                        }
                        RequestService.shared.request("http://localhost:3000/insertfood", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResposeFoods.self) { (result, food, err) in
                            guard let food = food as? BaseResposeFoods else {return}
                            if food.result{
                                let alert = UIAlertController(title: "Thông báo", message: food.message, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                                    cell.btnAdd.isEnabled = false
                                    cell.btnAdd.backgroundColor = .darkGray
                                    self.tableView.reloadData()
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                            self.tableView.reloadData()
                        }
                    }
                }
                    
            }
            else{
                let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập tên món ăn hoặc giá tiền", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
}
