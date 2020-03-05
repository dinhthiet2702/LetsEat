//
//  DetailHistoryCell.swift
//  LetsEat
//
//  Created by thiet on 3/5/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit

class DetailHistoryCell: UITableViewCell {
    @IBOutlet weak var imgfood: UIImageView!
    @IBOutlet weak var lbNameFood: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(htfoods:FoodsHistory) {
        imgfood.load(nameImage: htfoods.imgfood!)
        lbNameFood.text = htfoods.namefood!
        lbPrice.text = String("\(htfoods.price!) đ")
        lbAmount.text = htfoods.amount!
    }
}
