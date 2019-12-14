//
//  ButtonUICustom.swift
//  LetsEat
//
//  Created by Ân Lê on 12/13/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import Foundation
import UIKit
extension UIButton {
    func radiusCustome(value:CGFloat){
        self.layer.cornerRadius = value // edit add value
    }
    func customDropdown(textname:String) { //custom dropdown
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.radiusCustome(value: 10)
        self.setTitle(textname, for: .normal)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0) //custom button image and text
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 320, bottom: 0, right: 0)
    }
    
}
