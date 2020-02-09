//
//  FoodCell.swift
//  LetsEat
//
//  Created by thiet on 1/1/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {

    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(mf:MenuFood) {
        name.text = mf.name
        imgFood.image = UIImage(named: mf.imgFood)
    }

}
