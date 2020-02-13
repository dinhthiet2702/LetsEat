//
//  FoodsCell.swift
//  LetsEat
//
//  Created by thiet on 2/6/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit

class FoodsCell2: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var viewAmout: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var tfAmount: UITextField!
    
    var didadd:(()-> Void)! = nil
    var didChangeAmount:((_ amount:Int)-> Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindData(food: Foods) {
        img.image = UIImage(named: food.imgFood)
        name.text = food.nameFood
        price.text = String(food.price)
        tfAmount.text = String(food.amount)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func Add(_ sender: UIButton) {
        let amount = Int(tfAmount.text!)! + 1
        if didadd != nil{
            didadd()
            didChangeAmount(amount)
        }
    
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
    
    
}

