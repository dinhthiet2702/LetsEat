//
//  RegisterViewController.swift
//  LetsEat
//
//  Created by thiet on 2/18/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit
import Alamofire
class RegisterViewController: TransparentBarNavViewController {
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfBirtday: UIDatePicker!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfVeryPassword: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lbCheckUser: UILabel!
    @IBOutlet weak var lbCheckEmail: UILabel!
    @IBOutlet weak var lbCheckPassword: UILabel!
    @IBOutlet weak var lbVeryPassword: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomBackItem()
        tfUsername.delegate = self
        tfEmail.delegate = self
        tfPassword.delegate = self
        tfVeryPassword.delegate = self
        self.navigationItem.title = "ĐĂNG KÍ LETSEAT"
    }
    func checkUser(isCheck:Bool){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let selectedDate = dateFormatter.string(from: tfBirtday.date)
       let parameter  = [
        "firtname" : tfFirstName.text!,
        "lastname" : tfLastName.text!,
        "birtday" : selectedDate,
        "email" : tfEmail.text!,
        "phonenumber" : tfPhoneNumber.text!,
        "username" : tfUsername.text!,
        "password" : tfPassword.text!,
        "isCheck" : String(isCheck)
        ]
        RequestService.shared.request("http://localhost:3000/register", .post, parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponse.self) { (result, json, error) in
            guard let json = json as? BaseResponse else {return}
            if json.result && self.isValidateUsername(username: self.tfUsername.text!) == true{
                self.lbCheckUser.textColor = .green
                self.lbCheckUser.text = json.message
            }
            else{
                self.lbCheckUser.textColor = .red
                if self.isValidateUsername(username: self.tfUsername.text!) == false{
                    self.lbCheckUser.text = "Không thể sử dụng"
                }
                if self.tfUsername.text?.count == 0{
                    self.lbCheckUser.text = "Enter your username"
                }
                if json.result == false {
                    self.lbCheckUser.text = json.message
                }
                
            }
                
            
        }
    }
    func isCheckVeryPassword(verypass:String)->Bool {
        if verypass != tfPassword.text! {
            
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
    func isValidateUsername(username:String)->Bool{
       let usernameRegEx = "^(?=.*[a-z])(?=.*\\d)[a-zA-Z\\d\\S]{6,}$" // \\S không được có khoảng trắng
       let usernameTest = NSPredicate(format:"SELF MATCHES %@", usernameRegEx)
       let result = usernameTest.evaluate(with: username)
       return result
    }
    func isValideEmail(email:String)->Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    @IBAction func Register(_ sender: UIButton) {
        let isCheckEmail = isValideEmail(email: tfEmail.text!)
        let isCheckUser = isValidateUsername(username: tfUsername.text!)
        let isCheckPassword = isValidatePassword(password: tfPassword.text!)
        let isCheckVeryPass = isCheckVeryPassword(verypass: tfVeryPassword.text!)
        if (isCheckEmail == true ) && isCheckUser == true && isCheckPassword == true && isCheckUser == true && isCheckVeryPass == true{
            let alert:UIAlertController = UIAlertController(title: "Thông báo", message: "Đăng kí thành công", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                self.checkUser(isCheck: false)
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true, completion: nil)
        }
        else{
            let alert:UIAlertController = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập đủ thông tin", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    

}
extension RegisterViewController:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfUsername {
            checkUser(isCheck: true)
            
        }
        if textField == tfEmail {
            if isValideEmail(email: tfEmail.text!) == true {
                self.lbCheckEmail.textColor = . green
                self.lbCheckEmail.text = "Email có thể sử dụng"
            }
            else{
                self.lbCheckEmail.textColor = . red
                if isValideEmail(email: tfEmail.text!) == false{
                    self.lbCheckEmail.text = "Không phải là một email"
                }
                if tfEmail.text?.count == 0{
                    self.lbCheckEmail.text = "Email không được để trống"
                }
            }
        }
        if textField == tfPassword {
            if isValidatePassword(password: tfPassword.text!) == true {
                self.lbCheckPassword.textColor = . green
                self.lbCheckPassword.text = "Mật khẩu mạnh"
            }
            else{
                self.lbCheckPassword.textColor = . red
                if isValidatePassword(password: tfPassword.text!) == false {
                    self.lbCheckPassword.text = "Mật khẩu không dùng được"
                }
            }
        }
        if textField == tfVeryPassword {
            if isCheckVeryPassword(verypass: tfVeryPassword.text!) == true{
                lbVeryPassword.isHidden = true
            }
            else{
                lbVeryPassword.isHidden = false
                lbVeryPassword.textColor = .red
                if isCheckVeryPassword(verypass: tfVeryPassword.text!) == false{
                        lbVeryPassword.text = "Password is valid"
                    }
                if tfVeryPassword.text?.count == 0{
                    self.lbVeryPassword.text = "Password is null"
                }
            }
            
        }
        
    }
}
