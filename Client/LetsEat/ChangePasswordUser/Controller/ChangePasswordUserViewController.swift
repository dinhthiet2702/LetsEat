//
//  ChangePasswordUserViewController.swift
//  LetsEat
//
//  Created by thiet on 3/8/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit
import Alamofire
class ChangePasswordUserViewController: TransparentBarNavViewController {
    @IBOutlet weak var tfPasswordNow: UITextField!
    @IBOutlet weak var tfPasswordNew: UITextField!
    @IBOutlet weak var tfVeryPasswordNew: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lbCheckPassword: UILabel!
    @IBOutlet weak var lbVeryPassword: UILabel!
    var parameter:[String:String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        tfPasswordNew.delegate = self
        tfVeryPasswordNew.delegate = self
        btnSave.radiusCustome(value: 5)
        CustomBackItem()
        navigationItem.title = "Đổi mật khẩu"
        // Do any additional setup after loading the view.
    }
    func isCheckVeryPassword(verypass:String)->Bool {
        if verypass != tfPasswordNew.text! {
            return false
        }
        else{
            
            return true
        }
    }
    func isValidatePassword(password:String)->Bool{
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d\\S]{8,16}$" // \\S không được có khoảng trắng
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: password)
        return result
    }
    
    
    @IBAction func Save(_ sender: Any) {
        let isCheckPassword = isValidatePassword(password: tfPasswordNew.text!)
        let isCheckVeryPass = isCheckVeryPassword(verypass: tfVeryPasswordNew.text!)
        if isCheckPassword == true && isCheckVeryPass == true{
            self.parameter = [
                "id":user.id!,
                "password":tfPasswordNow.text!
            ]
            RequestService.shared.request("http://localhost:3000/checkPassword", .post, parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, json , error) in
                guard let json = json as? BaseResponse else {return}
                if json.result{
                    self.parameter = [
                        "id":user.id!,
                        "password":self.tfPasswordNew.text!
                    ]
                    RequestService.shared.request("http://localhost:3000/changepassword", .post, self.parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, data, error) in
                        guard let data = data as? BaseResponse else {return}
                        if data.result{
                            let alert1:UIAlertController = UIAlertController(title: "Thông báo", message: data.message, preferredStyle: .alert)
                            alert1.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                                let alert2:UIAlertController = UIAlertController(title: "Thông báo", message:"Bạn có muốn đăng nhập lại?" , preferredStyle: .alert)
                                alert2.addAction(UIAlertAction(title: "Không", style: .default, handler: {(_) in
                                    self.navigationController?.popViewController(animated: true)
                                }))
                                alert2.addAction(UIAlertAction(title: "Có", style: .default, handler: {(_) in
                                    let scence = self.view.window?.windowScene?.delegate as! SceneDelegate
                                    UserDefaults.standard.removeObject(forKey: "token")
                                    scence.logOut()
                                }))
                                self.present(alert2, animated: true, completion: nil)
                            }))
                            self.present(alert1, animated: true, completion: nil)
                        }
                    }
                }
                else{
                    let alert:UIAlertController = UIAlertController(title: "Thông báo", message: json.message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        else{
            let alert:UIAlertController = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập đúng thông tin", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
extension ChangePasswordUserViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfPasswordNew {
            if isValidatePassword(password: tfPasswordNew.text!) == true {
                self.lbCheckPassword.textColor = . green
                self.lbCheckPassword.text = "Mật khẩu mạnh"
            }
            else{
                self.lbCheckPassword.textColor = . red
                if isValidatePassword(password: tfPasswordNew.text!) == false {
                    self.lbCheckPassword.text = "Mật khẩu không dùng được"
                }
            }
        }
        if textField == tfVeryPasswordNew {
            if isCheckVeryPassword(verypass: tfVeryPasswordNew.text!) == true{
                lbVeryPassword.isHidden = true
            }
            else{
                lbVeryPassword.isHidden = false
                lbVeryPassword.textColor = .red
                if isCheckVeryPassword(verypass: tfVeryPasswordNew.text!) == false{
                        lbVeryPassword.text = "Password is valid"
                    }
                if tfVeryPasswordNew.text?.count == 0{
                    self.lbVeryPassword.text = "Password is null"
                }
            }
            
        }
    }
    
}
