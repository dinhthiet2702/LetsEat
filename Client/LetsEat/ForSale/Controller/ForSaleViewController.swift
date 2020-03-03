//
//  ForSaleViewController.swift
//  LetsEat
//
//  Created by thiet on 2/24/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit
import DKImagePickerController
import Alamofire

class ForSaleViewController: UIViewController {
    @IBOutlet weak var tfMenu: UITextField!
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    var arrImages:[UIImage] = []
    var parameter:[String:String]!
    let pickerController = DKImagePickerController()
    var idMenuFood:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgMenu.layer.cornerRadius = 10
        imgMenu.layer.borderWidth = 0.3
        btnNext.radiusCustome(value: 10)
        navigationItem.title = "Tạo menu cho bạn"
        // Do any additional setup after loading the view.
    }
    @IBAction func Next(_ sender: Any) {
        if tfMenu.text!.count > 0 {
            var dataImages : [Dictionary<String, Any>] = []
            self.arrImages.forEach { (img) in
                    // resize image
                let convertImage = img.jpegData(compressionQuality: 1000)
                dataImages = [
                    ["key" : "photo",
                    "value" : convertImage as Any]
                ]
            }
            RequestService.shared.upload("http://localhost:3000/photo", nil, ArrayResponse.self, dataImages) { (result, json, error) in
                   guard let json = json as? ArrayResponse else {return}
                    if json.result == true{
                        self.parameter = [
                            "name":self.tfMenu.text!,
                            "img":json.data.originalname!,
                            "user_id":user.id
                        ]
                        RequestService.shared.request("http://localhost:3000/insertmenufood", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResposeMenuFood.self) { (result, menu, err) in
                            guard let menu = menu as? BaseResposeMenuFood else {return}
                            if menu.result{
                                
                                let alert = UIAlertController(title: "Thông báo", message: menu.message, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                                    let foodsSaleVC = sb.instantiateViewController(identifier: "FoodsSaleViewController") as! FoodsSaleViewController
                                    foodsSaleVC.id = menu.data[0].id!
                                    self.navigationController?.pushViewController(foodsSaleVC, animated: true)
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                    else{
                        let alert = UIAlertController(title: "Thông báo", message: json.message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            else{
                let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập tên menu", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        
    }
    @IBAction func Choose(_ sender: Any) {
        
        pickerController.maxSelectableCount = 1
        pickerController.showsCancelButton = true
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            var images = [UIImage]()
            assets.forEach { (img) in
                img.fetchImage(with: CGSize(width: 300, height: 300)) { (image, info) in
                    if let image = image {
                        images.append(image)
                        self.imgMenu.image = image
                    }
                }
            }
            self.arrImages = images

        }
        self.present(pickerController, animated: true) {}
    }
}
