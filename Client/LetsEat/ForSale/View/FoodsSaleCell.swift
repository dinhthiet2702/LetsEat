//
//  FoodsSaleCell.swift
//  LetsEat
//
//  Created by thiet on 2/25/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit

class FoodsSaleCell: UITableViewCell {
    @IBOutlet weak var imgfood: UIImageView!
    @IBOutlet weak var namefood: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var btnMonChinh: UIButton!
    @IBOutlet weak var btnMonPhu: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnChoose: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    var didMonChinh:((_ btnMonChinh:UIButton)->Void)! = nil
    var didMonPhu:((_ btnMonPhu:UIButton)->Void)! = nil
    var didChoose:(()->Void)! = nil
    var didRemove:(()->Void)! = nil
    var didAddFood:(()->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnAddFood(_ sender: Any) {
        if didAddFood != nil {
            didAddFood()
        }
    }
    @IBAction func btn_MonChinh(_ sender: Any) {
        
            if didMonChinh != nil {
                didMonChinh(btnMonChinh)
            }
        
        
    }
    @IBAction func btn_MonPhu(_ sender: Any) {
        
            if didMonPhu != nil {
                didMonPhu(btnMonPhu)
            }
        
        
    }
    @IBAction func ChooseImg(_ sender: Any) {
        if didChoose != nil {
            didChoose()
        }
    }
    @IBAction func Remove(_ sender: Any) {
        if didRemove != nil {
            didRemove()
        }
    }
    
}
