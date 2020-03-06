//
//  EditMenuFoodViewController.swift
//  LetsEat
//
//  Created by thiet on 3/6/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit
import Alamofire
import DKImagePickerController
class EditMenuFoodViewController: TransparentBarNavViewController {
    
    @IBOutlet weak var btnEditImage: UIButton!
    @IBOutlet weak var btnCancelEditImage: UIButton!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var imgMenuFood: UIImageView!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var btnEditNameFood: UIButton!
    @IBOutlet weak var btnCancelEditNameFood: UIButton!
    @IBOutlet weak var tfNameFood: UITextField!
    let pickerController = DKImagePickerController()
    var arrImages:[UIImage] = []
    var menuFood:MenuFood!
    var parameter:[String:String]!
    var accpectEditImage:Bool? = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpview()
        
        // Do any additional setup after loading the view.
    }
    func setUpview(){
        tfNameFood.isUserInteractionEnabled = false
        imgMenuFood.load(nameImage: menuFood.img!)
        tfNameFood.text = menuFood.name!
        viewImage.isHidden = true
        navigationItem.title = "Chỉnh sửa menu của bạn"
        CustomBackItem()
        imgMenuFood.layer.cornerRadius = 10
        viewImage.layer.cornerRadius = 10
        btnEditImage.radiusCustome(value: 5)
        btnCancelEditImage.radiusCustome(value: 5)
        save.radiusCustome(value: 5)
        btnCancelEditNameFood.isHidden = true
        btnCancelEditNameFood.radiusCustome(value: 5)
    }
    @IBAction func EditImage(_ sender: UIButton) {
        self.accpectEditImage = true
        viewImage.isHidden = false
        btnEditImage.isHidden = true
        btnCancelEditImage.isHidden = false
        print(accpectEditImage!)
    }
    @IBAction func CancelEditImage(_ sender: UIButton) {
        self.accpectEditImage = false
        viewImage.isHidden = true
        btnEditImage.isHidden = false
        btnCancelEditImage.isHidden = true
        imgMenuFood.load(nameImage: menuFood.img!)
        print(accpectEditImage!)
    }
    @IBAction func EditNameFood(_ sender: Any) {
        btnEditNameFood.isHidden = true
        btnCancelEditNameFood.isHidden = false
        tfNameFood.isUserInteractionEnabled = true
    }
    @IBAction func CancelEditNameFood(_ sender: Any) {
        btnEditNameFood.isHidden = false
        btnCancelEditNameFood.isHidden = true
        tfNameFood.text = menuFood.name!
        tfNameFood.isUserInteractionEnabled = false
    }
    
    
    @IBAction func Choose(_ sender: UIButton) {
        pickerController.maxSelectableCount = 1
        pickerController.showsCancelButton = true
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            var images = [UIImage]()
            assets.forEach { (img) in
                img.fetchImage(with: CGSize(width: 300, height: 300)) { (image, info) in
                    if let image = image {
                        images.append(image)
                        self.imgMenuFood.image = image
                    }
                }
            }
            self.arrImages = images
        }
        self.present(pickerController, animated: true) {}
        
    }
    @IBAction func Save(_ sender: Any) {
        let alert:UIAlertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn lưu thay đổi", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Có", style: .default, handler: {(_) in
                self.parameter = [
                    "imgname":self.menuFood.img!,
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
                                    "id":self.menuFood.id!,
                                    "name":self.tfNameFood.text!,
                                    "img":json.data.originalname!
                                ]
                                RequestService.shared.request("http://localhost:3000/getmenu/didupload/edit", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, data, err) in
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
                            "id":self.menuFood.id!,
                            "name":self.tfNameFood.text!,
                            "img":self.menuFood.img!
                        ]
                        RequestService.shared.request("http://localhost:3000/getmenu/didupload/edit", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, data, err) in
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

