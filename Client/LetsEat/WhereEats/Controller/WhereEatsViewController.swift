//
//  WhereEatsViewController.swift
//  LetsEat
//
//  Created by thiet on 12/22/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class WhereEatsViewController: TransparentBarNavViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnNext: UIButton!
    var arrHinh:[imgWhereEats] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.allowsMultipleSelection = true
        btnNext.radiusCustome(value: 5)
        arrHinh = [
            imgWhereEats(imgName: "sang-trong", name: "Sang trọng"),
            imgWhereEats(imgName: "nha-hang", name: "Nhà hàng"),
            imgWhereEats(imgName: "street-food", name: "Street Food"),
            imgWhereEats(imgName: "quan-nhau", name: "Quán nhậu"),
            imgWhereEats(imgName: "san-vuon", name: "Sân vườn")
        ]
        // Do any additional setup after loading the view.
    }
    @IBAction func Next(_ sender: Any) {
        let MainVC = sb.instantiateViewController(identifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(MainVC, animated: true)
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
extension WhereEatsViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrHinh.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WhereEatsCellList", for: indexPath) as! WhereEatsCellList
        cell.binddata(img: arrHinh[indexPath.item])
        cell.imgWhereEats.layer.cornerRadius = 10
        cell.contentView.layer.cornerRadius = 10
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
