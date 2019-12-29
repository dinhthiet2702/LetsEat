//
//  Location_LanguageViewController.swift
//  LetsEat
//
//  Created by thiet on 12/15/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class Location_LanguageViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var arrLocal_Lang:[String]!
    var didSelectText:((_ textname:String)->Void)! = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
extension Location_LanguageViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLocal_Lang.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Location_LanguageCell", for: indexPath) as! Location_LanguageCell
        cell.textname.text = arrLocal_Lang[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if didSelectText != nil{
            didSelectText(arrLocal_Lang[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
