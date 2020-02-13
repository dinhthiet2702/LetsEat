//
//  DeliveryViewController.swift
//  LetsEat
//
//  Created by thiet on 12/28/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit
import FSPagerView

class DeliveryViewController: TransparentBarNavViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet{
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.transformer = FSPagerViewTransformer(type: .overlap)
            self.pagerView.itemSize = CGSize(width: 285, height: 180)
            self.pagerView.isInfinite = true //vo han hinh
            self.pagerView.contentMode = .scaleToFill
            self.pagerView.automaticSlidingInterval = 3.0
        }
    }
    var arrCard:[String] = ["card1","card2"]
    var arrFoodCategory:[MenuFood] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        arrFoodCategory = [
            MenuFood(id: "0", name: "FUMO - Beef Steak", imgFood: "fumo", kindFood: [
                kindFood(id: "1", name: "MÓN CHÍNH", food: [
                    Foods(id: "1", nameFood: "Thịt nướng", imgFood: "fumo", price: 70000, amount: 0),
                    Foods(id: "2", nameFood: "Thịt nguội", imgFood: "fumo", price: 70000, amount: 0),
                    Foods(id: "3", nameFood: "Thịt sông khói", imgFood: "fumo", price: 70000, amount: 0),
                    Foods(id: "4", nameFood: "Thịt sườn", imgFood: "fumo", price: 70000, amount: 0),
                    Foods(id: "5", nameFood: "Thịt quay", imgFood: "fumo", price: 70000, amount: 0)
                    ]),
                kindFood(id: "2", name: "MÓN PHỤ", food: [
                    Foods(id: "6",nameFood: "Canh cải", imgFood: "fumo", price: 70000, amount: 0),
                    Foods(id: "7",nameFood: "Cơm thêm", imgFood: "fumo", price: 70000, amount: 0),
                    Foods(id: "9",nameFood: "Thịt chim", imgFood: "fumo", price: 70000, amount: 0)
                ])
            ]),
            MenuFood(id: "0", name: "FUMO - Beef Steak", imgFood: "fumo", kindFood: [
                kindFood(id: "1", name: "MÓN CHÍNH", food: [
                    Foods(id: "1", nameFood: "Thịt luoc", imgFood: "fumo", price: 70000, amount: 0),
                    Foods(id: "2", nameFood: "Thịt nguội baki", imgFood: "fumo", price: 70000, amount: 0),
                    Foods(id: "3", nameFood: "Thịt khói", imgFood: "fumo", price: 70000, amount: 0),
                    Foods(id: "4", nameFood: "Thịt heo", imgFood: "fumo", price: 70000, amount: 0),
                    Foods(id: "5", nameFood: "Thịt chó", imgFood: "fumo", price: 70000, amount: 0)
                    ]),
                kindFood(id: "2", name: "MÓN PHỤ", food: [
                    Foods(id: "6",nameFood: "Canh rau muống", imgFood: "fumo", price: 70000, amount: 0),
                    Foods(id: "7",nameFood: "Cơm tấm", imgFood: "fumo", price: 70000, amount: 0),
                    Foods(id: "8",nameFood: "Rau chín", imgFood: "fumo", price: 70000, amount: 0),
                    Foods(id: "9",nameFood: "Thịt gÀ", imgFood: "fumo", price: 70000, amount: 0)
                ])
            ])
        ]
        tableView.tableHeaderView?.backgroundColor = .white
        pagerView.dataSource = self
        pagerView.delegate = self
        creatSearchBar(placeholder: "Tìm kiếm món ăn, địa điểm")
        self.CustomBackItem()
        
        // Do any additional setup after loading the view.
    }


}
extension DeliveryViewController:FSPagerViewDataSource,FSPagerViewDelegate{
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.arrCard.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: arrCard[index])
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.layer.cornerRadius = 10
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    
}
extension DeliveryViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return arrFoodCategory.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodCell
            cell.imgFood.layer.cornerRadius = 10
            cell.imgFood.clipsToBounds = true
            cell.bindData(mf: arrFoodCategory[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 40
        default:
            return 100
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return
        default:
            let menuFood = sb.instantiateViewController(withIdentifier: "MenuFoodViewController") as! MenuFoodViewController
            menuFood.arrMenuFood = self.arrFoodCategory[indexPath.row]
            self.navigationController?.pushViewController(menuFood, animated: true)
            print(indexPath.row)
        }
    }
}
