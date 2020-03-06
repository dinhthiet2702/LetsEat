//
//  FoodsMenuFoodCell.swift
//  LetsEat
//
//  Created by thiet on 3/7/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit

class FoodsMenuFoodCell: UITableViewCell {
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var nameFood: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var kindFood: UILabel!
    @IBOutlet weak var viewFoods: UIView!
    @IBOutlet weak var viewNonFoods: UIView!
    @IBOutlet weak var btnUploadFood: UIButton!
    var didEdit:(()->Void)! = nil
    var didRemove:(()->Void)! = nil
    var didUploadFood:(()->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(foods:Foods){
        imgFood.load(nameImage: foods.imgfood!)
        nameFood.text = foods.namefood!
        price.text = String("\(foods.price!) đ")
        kindFood.text = foods.namekindfood!
    }
    @IBAction func Edit(_ sender: Any) {
        if didEdit != nil{
            didEdit()
        }
    }
    @IBAction func remove(_ sender: Any) {
        if didRemove != nil{
            didRemove()
        }
    }
    @IBAction func UploadFood(_ sender: Any) {
        if didUploadFood != nil{
            didUploadFood()
        }
    }
    
}
