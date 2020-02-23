//
//  FoodCellOrder.swift
//  LetsEat
//
//  Created by thiet on 2/16/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit

class FoodCellOrder: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var viewAmout: UIView!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var viewFood: UIView!
    @IBOutlet weak var viewnonFood: UIView!
    @IBOutlet weak var btn_NonFood: UIButton!
    
    
    var didChangeAmount:((_ amount:Int)-> Void)! = nil
    var didRemove:(()-> Void)! = nil
    var didNonFood:(()-> Void)! = nil
        override func awakeFromNib() {
            super.awakeFromNib()
              // Initialization code
        }
    func bindData(food: Foods) {
        img.image = UIImage(named: food.imgfood)
        name.text = food.namefood
        price.text = String("\(food.price!) đ")
        tfAmount.text = String(food.amount)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

              // Configure the view for the selected state
    }
          
    @IBAction func Minus(_ sender: Any) {
        let amount = Int(tfAmount.text!)! - 1
        if didChangeAmount != nil {
            didChangeAmount(amount)
        }
    }
    @IBAction func Plus(_ sender: Any) {
        let amount = Int(tfAmount.text!)! + 1
        if didChangeAmount != nil {
            didChangeAmount(amount)
        }
    }
    @IBAction func Remove(_ sender: UIButton) {
        if didRemove != nil {
            didRemove()
        }
    }
    @IBAction func SelectFood(_ sender: UIButton) {
        if didNonFood != nil {
            didNonFood()
        }
    }
    
    
}
