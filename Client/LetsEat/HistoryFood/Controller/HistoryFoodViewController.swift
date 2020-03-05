//
//  HistoryFoodViewController.swift
//  LetsEat
//
//  Created by thiet on 3/4/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit
import Alamofire
class HistoryFoodViewController: TransparentBarNavViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var parameter:[String:String]!
    var arrDateFoods:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Lịch sử mua hàng"
        CustomBackItem()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.parameter = [
            "user_id":user.id!
        ]
        RequestService.shared.request("http://localhost:3000/gethistory", .post, parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponseHistoryFoods.self) { (result, data, err) in
            guard let data = data as? BaseResponseHistoryFoods else {return}
            if data.result{
                var arrDate:[String] = []
                for i in data.data!{
                    arrDate.append(i.dateorder!)
                }
                self.arrDateFoods = arrDate.unique()
            }
            self.tableView.reloadData()
        }
        
        
    }


}
extension HistoryFoodViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrDateFoods.count > 0 ? self.arrDateFoods.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        if self.arrDateFoods.count > 0{
            cell.viewHistory.isHidden = false
            cell.viewNonHistory.isHidden = true
            cell.lbDateFood.text = self.arrDateFoods[indexPath.row]
            cell.lbNameUser.text = "\(user.firtname ?? "Không") \(user.lastname ?? "khả dụng")"
        }
        else{
            cell.viewHistory.isHidden = true
            cell.viewNonHistory.isHidden = false
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrDateFoods.count > 0{
            tableView.allowsSelection = true
            let DetailHistoryVC = sb.instantiateViewController(withIdentifier: "DetailHistoryViewController") as! DetailHistoryViewController
            self.parameter = [
                "dateorder": arrDateFoods[indexPath.row]
            ]
            RequestService.shared.request("http://localhost:3000/gethistory/datefoods", .post, parameter, URLEncodedFormParameterEncoder.default, nil, BaseResponseHistoryFoods.self) { (result, data, err) in
                guard let data = data as? BaseResponseHistoryFoods else {return}
                if data.result{
                    DetailHistoryVC.arrHistoryFoods = data.data!
                    self.navigationController?.pushViewController(DetailHistoryVC, animated: true)
                }
            }
        }
        else{
            tableView.allowsSelection = false
        }
        
    }
}
