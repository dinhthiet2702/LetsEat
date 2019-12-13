//
//  TextFieldCustom.swift
//  LetsEat
//
//  Created by Ân Lê on 12/13/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import Foundation
import UIKit
extension UITextField{
    func borderBottomOnly(color : CGColor) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width , height: 1)
        bottomLine.backgroundColor = color
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    func itemHover(item : String){
        self.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: item)
        imageView.image = image
        self.rightView = imageView
    }
}
