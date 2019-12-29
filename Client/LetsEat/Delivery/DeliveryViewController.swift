//
//  DeliveryViewController.swift
//  LetsEat
//
//  Created by thiet on 12/28/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class DeliveryViewController: TransparentBarNavViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        creatSearchBar(placeholder: "Tìm kiếm món ăn, địa điểm")
        self.CustomBackItem()
        // Do any additional setup after loading the view.
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
