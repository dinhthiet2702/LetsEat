//
//  DetailHistoryViewController.swift
//  LetsEat
//
//  Created by thiet on 3/5/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit

class DetailHistoryViewController: TransparentBarNavViewController {
    @IBOutlet weak var tableView: UITableView!
    var arrHistoryFoods:[FoodsHistory] = []
    @IBOutlet weak var lbTotal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Chi tiết đơn hàng"
        CustomBackItem()
        totalPrice()
        // Do any additional setup after loading the view.
    }
    func totalPrice(){
        var total:Int = 0
        for i in arrHistoryFoods{
            total += Int(i.amount)!*Int(i.price)!
        }
        lbTotal.text = "\(total) đ"
    }
        

}
extension DetailHistoryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHistoryFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailHistoryCell", for: indexPath) as! DetailHistoryCell
        cell.imgfood.layer.cornerRadius = 10
        cell.bindData(htfoods: arrHistoryFoods[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
