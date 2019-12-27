//
//  LocationCellList.swift
//  LetsEat
//
//  Created by thiet on 12/27/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class LocationCellList: UICollectionViewCell {
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    func bindData(food:imgFoodLocation) {
        imgFood.image = UIImage(named: food.nameImg)
        lbName.text = food.nameFood
    }
    
}
