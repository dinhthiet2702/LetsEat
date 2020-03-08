//
//  MainViewController.swift
//  LetsEat
//
//  Created by thiet on 12/23/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: TransparentBarNavViewController {
    @IBOutlet weak var tableView: UITableView!
    private let tableHeaderHeight:CGFloat = 100
    var headerView:HeaderView!
    var arrMenu:[Menu]!
    var arrMenuFood:[MenuFood] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView = tableView.tableHeaderView as? HeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: tableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderHeight)
        UpdateHeaderView()
        arrMenu = [
            Menu(imgMenu: "foodblog", nameMenu: "Food Blog"),
            Menu(imgMenu: "delivery", nameMenu: "Delivery"),
            Menu(imgMenu: "booking", nameMenu: "Booking"),
            Menu(imgMenu: "takeaway", nameMenu: "Take Away"),
            Menu(imgMenu: "foodtour", nameMenu: "Food Tour"),
            Menu(imgMenu: "plan", nameMenu: "Plan"),
            Menu(imgMenu: "rewards", nameMenu: "Rewards")
        ]
        
        creatSearchBar(placeholder: "Tìm kiếm nhanh")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        RequestService.shared.request("http://localhost:3000/delivery", .get, nil, URLEncodedFormParameterEncoder.default, nil, BaseResposeMenuFood.self) { (result, data, error) in
            guard let data = data as? BaseResposeMenuFood else {return}
            if data.result{
                self.arrMenuFood =  data.data!
            }
            self.tableView.reloadData()
        }
    }
    func UpdateHeaderView(){
        var headerReact = CGRect(x: 0, y: -tableHeaderHeight, width: tableView.bounds.width, height: tableHeaderHeight)
        if tableView.contentOffset.y < -tableHeaderHeight{
            headerReact.origin.y = tableView.contentOffset.y
            headerReact.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerReact
    }
   
}
extension MainViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
            cell.arrMenu = self.arrMenu
            
            cell.pushView = { (item) in
                switch item {
                case 0:
                    let FoodBlogVC = sb.instantiateViewController(identifier: "FoodBlogViewController") as! FoodBlogViewController
                    
                    self.navigationController?.pushViewController(FoodBlogVC, animated: true)
                case 1:
                    let DeliveryVC = sb.instantiateViewController(identifier: "DeliveryViewController") as! DeliveryViewController
                    self.navigationController?.pushViewController(DeliveryVC, animated: true)
                default:
                let FoodBlogVC = sb.instantiateViewController(identifier: "FoodBlogViewController") as! FoodBlogViewController
                
                self.navigationController?.pushViewController(FoodBlogVC, animated: true)
                    
                }
                
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
            cell.arrMenuFood = self.arrMenuFood
            cell.collectionview.reloadData()
            cell.didSelectMenuFood = { (mf) in
                let menuFood = sb.instantiateViewController(withIdentifier: "MenuFoodViewController") as! MenuFoodViewController
                let parameter = [
                    "menufood_id": mf.id!
                ]
                menuFood.arrMenuFood = mf
                RequestService.shared.request("http://localhost:3000/delivery/menufood", .post, parameter, URLEncodedFormParameterEncoder.default, nil, BaseResposeFoods.self) { (result, data, err) in
                    guard let data = data as? BaseResposeFoods else {return}
                    if data.result{
                        menuFood.arrFoods = data.data!
                        self.navigationController?.pushViewController(menuFood, animated: true)
                    }
                }
            }
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        default:
            return 300
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UpdateHeaderView()
    }
}
