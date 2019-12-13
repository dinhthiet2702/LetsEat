//
//  ViewController.swift
//  LetsEat
//
//  Created by thiet on 12/13/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let nameImg : [String] = ["Ico-fettle-proper"]
    @IBOutlet weak var usernameLb: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordLb: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let moreInfoVC = sb.instantiateViewController(identifier: "MoreInfoViewController") as! MoreInfoViewController
        
        self.present(moreInfoVC, animated: true, completion: nil)
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


