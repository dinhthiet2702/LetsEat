//
//  MenuFoodManagerCell.swift
//  LetsEat
//
//  Created by thiet on 3/5/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit

class MenuFoodManagerCell: UITableViewCell {
    @IBOutlet weak var imgMenufood: UIImageView!
    @IBOutlet weak var lbMenuFood: UILabel!
    @IBOutlet weak var btndidUpload: UIButton!
    
    @IBOutlet weak var viewMenuFoodUser: UIView!
    @IBOutlet weak var viewNonMenuFood: UIView!
    var didEdit:(()->Void)! = nil
    var didRemove:(()->Void)! = nil
    var didUploadMenu:(()->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func binData(mf:MenuFood){
        lbMenuFood.text = mf.name!
        imgMenufood.load(nameImage: mf.img!)
    }
    @IBAction func edit(_ sender: Any) {
        if didEdit != nil{
            didEdit()
        }
    }
    @IBAction func remove(_ sender: Any) {
        if didRemove != nil{
            didRemove()
        }
    }
    @IBAction func UploadMenu(_ sender: Any) {
        if didUploadMenu != nil{
            didUploadMenu()
        }
    }
    
}
