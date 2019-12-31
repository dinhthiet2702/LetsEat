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
            self.pagerView.contentMode = .scaleAspectFit
            self.pagerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.pagerView.automaticSlidingInterval = 3.0
        }
    }
    var arrCard:[String] = ["card1","card2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView?.backgroundColor = .white
        pagerView.dataSource = self
        pagerView.delegate = self
        creatSearchBar(placeholder: "Tìm kiếm món ăn, địa điểm")
        self.CustomBackItem()
        // Do any additional setup after loading the view.
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
            return 10
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath) as! FoodCell
            cell.textLabel?.text = "10"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 20
        default:
            return 100
        }
    }
}
