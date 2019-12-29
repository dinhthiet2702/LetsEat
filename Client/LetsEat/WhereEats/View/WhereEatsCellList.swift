//
//  WhereEatsCellList.swift
//  LetsEat
//
//  Created by thiet on 12/22/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class WhereEatsCellList: UICollectionViewCell {
    @IBOutlet weak var imgWhereEats: UIImageView!
    @IBOutlet weak var lbWhereEats: UILabel!
    func binddata(img:imgWhereEats) {
        imgWhereEats.image = UIImage(named: img.imgName)
        lbWhereEats.text = img.name
    }
}
