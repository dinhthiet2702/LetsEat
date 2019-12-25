//
//  MainViewController.swift
//  LetsEat
//
//  Created by thiet on 12/23/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class MainViewController: TransparentBarNavViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgHeader: UIImageView!
    var arrMenu:[Menu]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrMenu = [
            Menu(imgMenu: "foodblog", nameMenu: "Food Blog"),
            Menu(imgMenu: "delivery", nameMenu: "Delivery"),
            Menu(imgMenu: "booking", nameMenu: "Reservation"),
            Menu(imgMenu: "takeaway", nameMenu: "Take Away"),
            Menu(imgMenu: "foodtour", nameMenu: "Food Tour"),
            Menu(imgMenu: "plan", nameMenu: "Eating Plan"),
            Menu(imgMenu: "rewards", nameMenu: "Rewards")
        ]
        
        
        creatSearchBar(placeholder: "Tìm kiếm nhanh")
        
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
            cell.layer.cornerRadius = 30
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
            
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        default:
            return 178
        }
    }
}
