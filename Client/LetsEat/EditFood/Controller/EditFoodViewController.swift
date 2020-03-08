//
//  EditFoodViewController.swift
//  LetsEat
//
//  Created by thiet on 3/7/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit
import Alamofire
import DKImagePickerController
class EditFoodViewController: TransparentBarNavViewController {

    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var editImage: UIButton!
    @IBOutlet weak var canEditImage: UIButton!
    @IBOutlet weak var tfNameFood: UITextField!
    @IBOutlet weak var btnEditNameFood: UIButton!
    @IBOutlet weak var btnEditPrice: UIButton!
    @IBOutlet weak var canEditNameFood: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var btnCanEditPrice: UIButton!
    @IBOutlet weak var btnMonChinh: UIButton!
    @IBOutlet weak var btnMonPhu: UIButton!
    var arrImages:[UIImage] = []
    let pickerController = DKImagePickerController()
    var parameter:[String:String]!
    var accpectEditImage:Bool? = false
    var food:Foods!
    var namekindfood:String? = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpview()
        // Do any additional setup after loading the view.
    }
    func setUpview(){
        tfNameFood.isUserInteractionEnabled = false
        tfPrice.isUserInteractionEnabled = false
        imgFood.load(nameImage: food.imgfood!)
        tfNameFood.text = food.namefood!
        tfPrice.text = food.price!
        viewImage.isHidden = true
        navigationItem.title = "Chỉnh sửa món ăn của bạn"
        CustomBackItem()
        imgFood.layer.cornerRadius = 10
        viewImage.layer.cornerRadius = 10
        tfPrice.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        tfNameFood.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        canEditNameFood.radiusCustome(value: 5)
        btnCanEditPrice.radiusCustome(value: 5)
        canEditImage.radiusCustome(value: 5)
        editImage.radiusCustome(value: 5)
        btnSave.radiusCustome(value: 5)
        canEditNameFood.isHidden = true
        canEditImage.isHidden = true
        btnCanEditPrice.isHidden = true
        if food.namekindfood! == "MÓN CHÍNH"{
            btnMonChinh.isSelected = true
        }
        else if food.namekindfood! == "MÓN PHỤ"{
            btnMonPhu.isSelected = true
        }
    }
    @IBAction func editImage(_ sender: Any) {
        viewImage.isHidden = false
        canEditImage.isHidden = false
        editImage.isHidden = true
        self.accpectEditImage = true
    }
    @IBAction func canEditImage(_ sender: Any) {
        viewImage.isHidden = true
        canEditImage.isHidden = true
        editImage.isHidden = false
        imgFood.load(nameImage: food.imgfood!)
        self.accpectEditImage = false
    }
    @IBAction func editNameFood(_ sender: Any) {
        tfNameFood.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btnEditNameFood.isHidden = true
        canEditNameFood.isHidden = false
        tfNameFood.isUserInteractionEnabled = true
    }
    @IBAction func canEditNameFood(_ sender: Any) {
        tfNameFood.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        canEditNameFood.isHidden = true
        btnEditNameFood.isHidden = false
        tfNameFood.text = food.namefood!
        tfNameFood.isUserInteractionEnabled = false
    }
    @IBAction func canEditPrice(_ sender: Any) {
        tfPrice.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        btnCanEditPrice.isHidden = true
        tfPrice.text = food.price!
        btnEditPrice.isHidden = false
        tfPrice.isUserInteractionEnabled = false
    }
    @IBAction func editPrice(_ sender: Any) {
        tfPrice.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        btnCanEditPrice.isHidden = false
        btnEditPrice.isHidden = true
        tfPrice.isUserInteractionEnabled = true
    }
    @IBAction func monChinh(_ sender: Any) {
        btnMonPhu.isSelected = false
        btnMonChinh.isSelected = true
        self.namekindfood = "MÓN CHÍNH"
    }
    @IBAction func monPhu(_ sender: Any) {
        btnMonPhu.isSelected = true
        btnMonChinh.isSelected = false
        self.namekindfood = "MÓN PHỤ"
    }
    
    
    @IBAction func Save(_ sender: Any) {
        print(namekindfood!)
        let alert:UIAlertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn lưu thay đổi", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Có", style: .default, handler: {(_) in
                self.parameter = [
                    "imgname":self.food.imgfood!,
                    "accpectEditImage":String(self.accpectEditImage!)
                ]
                RequestService.shared.request("http://localhost:3000/removephoto", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, json, err) in
                    guard let json = json as? BaseResponse else {return}
                    if json.result{
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
                                    "id":self.food.id!,
                                    "namefood":self.tfNameFood.text!,
                                    "imgfood":json.data.originalname!,
                                    "price":self.tfPrice.text!,
                                    "namekindfood":self.namekindfood!
                                ]
                                RequestService.shared.request("http://localhost:3000/getmenu/didupload/foods/edit", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, data, err) in
                                    guard let data = data as? BaseResponse else {return}
                                        if data.result{
                                            let alert1:UIAlertController = UIAlertController(title: "Thông báo", message: data.message, preferredStyle: .alert)
                                                alert1.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                                                    self.navigationController?.popViewController(animated: true)
                                        }))
                                        self.present(alert1, animated: true, completion: nil)
                                    }
                                }
                            }
                        }
                    }
                    else{
                        self.parameter = [
                            "id":self.food.id!,
                            "namefood":self.tfNameFood.text!,
                            "imgfood":self.food.imgfood!,
                            "price":self.tfPrice.text!,
                            "namekindfood":self.namekindfood!
                        ]
                        RequestService.shared.request("http://localhost:3000/getmenu/didupload/foods/edit", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, data, err) in
                            guard let data = data as? BaseResponse else {return}
                                if data.result{
                                    let alert1:UIAlertController = UIAlertController(title: "Thông báo", message: data.message, preferredStyle: .alert)
                                        alert1.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                                            self.navigationController?.popViewController(animated: true)
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
    @IBAction func Choose(_ sender: Any) {
        pickerController.maxSelectableCount = 1
               pickerController.showsCancelButton = true
               pickerController.didSelectAssets = { (assets: [DKAsset]) in
                   var images = [UIImage]()
                   assets.forEach { (img) in
                       img.fetchImage(with: CGSize(width: 300, height: 300)) { (image, info) in
                           if let image = image {
                               images.append(image)
                               self.imgFood.image = image
                           }
                       }
                   }
                   self.arrImages = images
               }
        self.present(pickerController, animated: true) {}
    }
}
