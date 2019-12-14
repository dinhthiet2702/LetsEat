//
//  ButtonUIAction.swift
//  LetsEat
//
//  Created by thiet on 12/15/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import Foundation
import UIKit
extension UIButton {
    
    func checkGender(radioUncheck1:UIButton, radioUncheck2:UIButton){
        if self.isSelected{
            self.isSelected = false
        }
        else{
            self.isSelected = true
            radioUncheck1.isSelected = false
            radioUncheck2.isSelected = false
        }
    }
    
}
