//
//  MenuCellList.swift
//  LetsEat
//
//  Created by thiet on 12/26/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class MenuCellList: UICollectionViewCell {
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lbMenu: UILabel!
    
    func bindData(menu:Menu) {
        imgMenu.image = UIImage(named: menu.imgMenu)
        lbMenu.text = menu.nameMenu
    }
}
