//
//  Favorite_FoodCellList.swift
//  LetsEat
//
//  Created by thiet on 12/16/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class Favorite_FoodCellList: UICollectionViewCell {
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lbNameFood: UILabel!
    func bindData(img: imgFoodLocation) {
        imgFood.image = UIImage(named: img.nameImg)
        lbNameFood.text = img.nameFood
    }
}

