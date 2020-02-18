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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func checkUser(isCheck:Bool){
       let parameter  = [
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
        print(isCheckVeryPassword(verypass: tfVeryPassword.text!))
        
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
                if tfPassword.text?.count == 0{
                    self.lbCheckPassword.text = "Enter your password"
                }
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
                lbVeryPassword.text = "Password is valid"
            }
            
        }
        
    }
}
