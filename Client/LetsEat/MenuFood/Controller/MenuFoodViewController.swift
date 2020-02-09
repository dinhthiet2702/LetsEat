//
//  MenuFoodViewController.swift
//  LetsEat
//
//  Created by thiet on 1/3/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit

class MenuFoodViewController: TransparentBarNavViewController {
    @IBOutlet weak var tableView: UITableView!
    var pushView:(()-> Void)! = nil
    var titleView:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CustomBackItem()
        navigationItem.title = titleView
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MenuFoodViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        default:
            return 3
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Món chính"
        default:
            return "Món phụ"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodsCell", for: indexPath) as! FoodsCell
            cell.didadd = {
                cell.viewAmout.isHidden = false
                cell.btnAdd.isHidden = true
            }
            cell.didChangeAmount = { (amount) in
                cell.tfAmount.text = String(amount)
                if amount <= 0{
                    cell.viewAmout.isHidden = true
                    cell.btnAdd.isHidden = false
                }
                print(amount)
                self.tableView.reloadData()
                
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodsCell", for: indexPath) as! FoodsCell
            cell.didadd = {
                cell.viewAmout.isHidden = false
                cell.btnAdd.isHidden = true
            }
            cell.didChangeAmount = { (amount) in
                cell.tfAmount.text = String(amount)
                if amount <= 0{
                    cell.viewAmout.isHidden = true
                    cell.btnAdd.isHidden = false
                }
                self.tableView.reloadData()
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        default:
            return 150
        }
    }
    
}
