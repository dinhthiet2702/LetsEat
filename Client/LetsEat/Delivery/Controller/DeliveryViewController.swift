//
//  DeliveryViewController.swift
//  LetsEat
//
//  Created by thiet on 12/28/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit
import FSPagerView
import Alamofire

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
        requestData()
        tableView.tableHeaderView?.backgroundColor = .white
        pagerView.dataSource = self
        pagerView.delegate = self
        creatSearchBar(placeholder: "Tìm kiếm món ăn, địa điểm")
        self.CustomBackItem()
        
        // Do any additional setup after loading the view.
    }
    func requestData() {
        RequestService.shared.request("http://localhost:3000/delivery", .get, nil, URLEncodedFormParameterEncoder.default, nil, BaseResposeMenuFood.self) { (result, data, error) in
            guard let data = data as? BaseResposeMenuFood else {return}
            if data.result{
                self.arrFoodCategory =  data.data!
            }
            self.tableView.reloadData()
        }
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
            return self.arrFoodCategory.count
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
            let parameter = [
                "menufood_id": arrFoodCategory[indexPath.row].id!
            ]
            menuFood.arrMenuFood = arrFoodCategory[indexPath.row]
            RequestService.shared.request("http://localhost:3000/delivery/menufood", .post, parameter, URLEncodedFormParameterEncoder.default, nil, BaseResposeFoods.self) { (result, data, err) in
                guard let data = data as? BaseResposeFoods else {return}
                if data.result{
                    menuFood.arrFoods = data.data!
                    self.navigationController?.pushViewController(menuFood, animated: true)
                }
            }
        }
    }
}
