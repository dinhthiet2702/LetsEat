//
//  secondCell.swift
//  LetsEat
//
//  Created by thiet on 12/24/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit
import Alamofire
class LocationCell: UITableViewCell {
    @IBOutlet weak var collectionview: UICollectionView!
    var arrMenuFood:[MenuFood]!
    var didSelectMenuFood:((_ mf:MenuFood)->Void)! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension LocationCell:UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.arrMenuFood.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "LocationCellList", for: indexPath) as! LocationCellList
        cell.bindData(mf: arrMenuFood[indexPath.item])
        cell.contentView.layer.cornerRadius = 10
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didSelectMenuFood != nil{
            didSelectMenuFood(arrMenuFood[indexPath.item])
        }
    }
    
}
