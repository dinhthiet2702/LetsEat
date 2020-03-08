//
//  ChangeInfoUserViewController.swift
//  LetsEat
//
//  Created by thiet on 3/8/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit
import Alamofire

class ChangeInfoUserViewController: TransparentBarNavViewController {
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var birtday: UIDatePicker!
    @IBOutlet weak var btnNu: UIButton!
    @IBOutlet weak var btnNam: UIButton!
    @IBOutlet weak var btnUnknow: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var viewGender: UIView!
    let dateFormatter = DateFormatter()
    var gender:String? = user.gender!
    var parameter:[String:String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        CustomBackItem()
        let segmentBarItem = UIBarButtonItem(title: "Sửa", style: .plain, target: self, action: #selector(edit))
        navigationItem.rightBarButtonItem = segmentBarItem
        // Do any additional setup after loading the view.
    }
    @objc func edit() {
        tfFirstName.isUserInteractionEnabled = true
        tfFirstName.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tfLastName.isUserInteractionEnabled = true
        tfLastName.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if user.email == nil{
            tfEmail.isUserInteractionEnabled = true
            tfEmail.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        tfPhoneNumber.isUserInteractionEnabled = true
        tfPhoneNumber.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        birtday.isUserInteractionEnabled = true
        viewGender.isUserInteractionEnabled = true
        viewGender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
       }
    func setupView() {
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateFromString = dateFormatter.date(from: user.birtday ?? "01/01/1970")
        birtday.date = dateFromString ?? Date()
        navigationItem.title = "Chỉnh sửa thông tin"
        btnSave.radiusCustome(value: 5)
        tfFirstName.isUserInteractionEnabled = false
        tfFirstName.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        tfFirstName.text = user.firtname ?? ""
        tfLastName.isUserInteractionEnabled = false
        tfLastName.text = user.lastname ?? ""
        tfLastName.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        tfEmail.isUserInteractionEnabled = false
        tfEmail.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        tfEmail.text = user.email ?? ""
        tfPhoneNumber.isUserInteractionEnabled = false
        tfPhoneNumber.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        tfPhoneNumber.text = user.phonenumber ?? ""
        birtday.isUserInteractionEnabled = false
        viewGender.isUserInteractionEnabled = false
        viewGender.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        if user.gender == "Nam"{
            btnNam.isSelected = true
        }
        else if user.gender == "Nữ"{
            btnNu.isSelected = true
        }
        else if user.gender == "Unknown"{
            btnUnknow.isSelected = true
        }
    }
    @IBAction func Nu(_ sender: Any) {
        self.gender = "Nữ"
        btnNam.isSelected = false
        btnNu.isSelected = true
        btnUnknow.isSelected = false
    }
    @IBAction func Nam(_ sender: Any) {
        self.gender = "Nam"
        btnNam.isSelected = true
        btnNu.isSelected = false
        btnUnknow.isSelected = false
    }
    @IBAction func Unknow(_ sender: Any) {
        self.gender = "Unknown"
        btnNam.isSelected = false
        btnNu.isSelected = false
        btnUnknow.isSelected = true
    }
    @IBAction func Save(_ sender: Any) {
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let selectedDate = dateFormatter.string(from: birtday.date)
        self.parameter = [
            "id":user.id!,
            "firtname": tfFirstName.text!,
            "lastname": tfLastName.text!,
            "birtday": selectedDate,
            "email": tfEmail.text!,
            "phonenumber": tfPhoneNumber.text!,
            "gender":self.gender ?? ""
        ]
        RequestService.shared.request("http://localhost:3000/editInfoUser", .post, parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, json, error) in
            guard let json = json as? BaseResponse else {return}
            
            if json.result{
                let alert:UIAlertController = UIAlertController(title: "Thông báo", message: json.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    RequestService.shared.request("http://localhost:3000/checkUser", .post, ["id":user.id!], URLEncodedFormParameterEncoder.default, nil, ResultCheckUser.self) { (result, check, error) in
                        guard let check = check as? ResultCheckUser else {return}
                        if check.result{
                            user = check.data[0]
                        }
                    }
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}
