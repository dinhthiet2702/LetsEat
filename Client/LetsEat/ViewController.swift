//
//  ViewController.swift
//  LetsEat
//
//  Created by thiet on 12/13/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: TransparentBarNavViewController {
    let nameImg : [String] = ["Ico-fettle-proper"]
    @IBOutlet weak var usernameLb: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordLb: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.object(forKey: "token") != nil{
            let token = UserDefaults.standard.object(forKey: "token") as! String
            let parameter = [
                "token": token
            ]
            RequestService.shared.request("http://localhost:3000/check", .post, parameter, URLEncodedFormParameterEncoder.default, nil, Result.self) { (result, json, error) in
                guard let json = json as? Result else {return}
                if json.result{
                    let scence = self.view.window?.windowScene?.delegate as! SceneDelegate
                    scence.login(isLog: true)
                }
                 else{
                     let alert:UIAlertController = UIAlertController(title: "Thông báo", message: json.message, preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                         self.present(alert, animated: true, completion: nil)
                 }
            }
            
        }
        setupView()
        usernameLb.delegate = self
        passwordLb.delegate = self
        
        // Do any additional setup after loading the view.
    }

    func setupView(){
        usernameLb.borderBottomOnly(color : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) )
        loginBtn.radiusCustome(value: 5)
        passwordLb.borderBottomOnly(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    }
  
    @IBAction func usernameLb(_ sender: Any) {
        
    }
    @IBAction func btn_Login(_ sender: UIButton) {
        let parameter = [
            "username" : usernameLb.text!,
            "password" : passwordLb.text!
            ]
        RequestService.shared.request("http://localhost:3000/login", .post, parameter, URLEncodedFormParameterEncoder.default, nil, Token.self) { (result, data, error) in
                guard let data = data as? Token else {return}
            if data.result == true {
                UserDefaults.standard.set(data.token, forKey: "token")
                let moreInfoVC = sb.instantiateViewController(identifier: "MoreInfoViewController") as! MoreInfoViewController
                self.navigationController?.pushViewController(moreInfoVC, animated: true)
            }
            else{
                let alert:UIAlertController = UIAlertController(title: "Thông báo", message: data.message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    @IBAction func Register(_ sender: Any) {
        let RegisterVC = sb.instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(RegisterVC, animated: true)
    }
    
    
}
extension ViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameLb {
            usernameLb.borderBottomOnly(color: #colorLiteral(red: 0.984518826, green: 0.4054985344, blue: 0.1091441438, alpha: 1))
            usernameLb.itemHover(item: "Ico-fettle-proper")
            
        }
        if textField == passwordLb {
            passwordLb.borderBottomOnly(color: #colorLiteral(red: 0.984518826, green: 0.4054985344, blue: 0.1091441438, alpha: 1))
            passwordLb.itemHover(item: "Ico-fettle-proper")
            
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameLb {
            usernameLb.borderBottomOnly(color : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) )
            usernameLb.rightView?.isHidden = true
            
        }
        if textField == passwordLb {
            passwordLb.borderBottomOnly(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
            passwordLb.rightView?.isHidden = true
            
        }
    }
}


