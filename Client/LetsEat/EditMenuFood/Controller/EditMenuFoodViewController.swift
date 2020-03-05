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
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpview()
        print(menuFood!)
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
        viewImage.isHidden = false
        btnEditImage.isHidden = true
        btnCancelEditImage.isHidden = false
    }
    @IBAction func CancelEditImage(_ sender: UIButton) {
        viewImage.isHidden = true
        btnEditImage.isHidden = false
        btnCancelEditImage.isHidden = true
        imgMenuFood.load(nameImage: menuFood.img!)
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

