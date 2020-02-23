//
//  Favorite_FoodViewController.swift
//  LetsEat
//
//  Created by thiet on 12/16/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class Favorite_FoodViewController: TransparentBarNavViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var btnNext: UIButton!
    var arrImgCatgory:[imgFoodLocation] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.allowsMultipleSelection = true
        arrImgCatgory = [imgFoodLocation(nameImg: "mon-viet", nameFood: "Món Việt"),
                         imgFoodLocation(nameImg: "mon-han", nameFood: "Món Hàn"),
                         imgFoodLocation(nameImg: "mon-hoa", nameFood: "Món Hoa"),
                         imgFoodLocation(nameImg: "mon-ando", nameFood: "Món Ấn Độ"),
                         imgFoodLocation(nameImg: "mon-thai", nameFood: "Món Thái"),
                         imgFoodLocation(nameImg: "mon-sing", nameFood: "Món Singapore"),
                         imgFoodLocation(nameImg: "mon-my", nameFood: "Món Mỹ"),
                         imgFoodLocation(nameImg: "mon-tbn", nameFood: "Món Tây Ban Nha"),
                         imgFoodLocation(nameImg: "mon-nhat", nameFood: "Món Nhật"),
                         imgFoodLocation(nameImg: "mon-mexico", nameFood: "Món Mexico"),
                         imgFoodLocation(nameImg: "mon-phap", nameFood: "Món Pháp"),
                         imgFoodLocation(nameImg: "mon-agentina", nameFood: "Món Agentina")
        ]
        hideButtonBack(true)
        btnNext.radiusCustome(value: 5)
    }
    @IBAction func Next(_ sender: UIButton) {
        let WhereEats = sb.instantiateViewController(identifier: "WhereEatsViewController") as! WhereEatsViewController
        self.navigationController?.pushViewController(WhereEats, animated: true)
    }
    
}
extension Favorite_FoodViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImgCatgory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Favorite_FoodCellList", for: indexPath) as! Favorite_FoodCellList
        cell.bindData(img: arrImgCatgory[indexPath.item])
        cell.imgFood.layer.cornerRadius = 10
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.clipsToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.reloadItems(at: [indexPath])
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = (cell?.contentView.frame.width)!
        cell?.layer.cornerRadius = 10
        cell?.layer.borderColor = UIColor(cgColor: #colorLiteral(red: 0.003797804937, green: 0.5666219592, blue: 0.7788453102, alpha: 0.5)).cgColor
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
         let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0
    }
}
