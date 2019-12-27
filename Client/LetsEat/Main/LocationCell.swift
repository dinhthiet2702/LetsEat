//
//  secondCell.swift
//  LetsEat
//
//  Created by thiet on 12/24/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
    @IBOutlet weak var collectionview: UICollectionView!
    var arrFood:[imgFoodLocation]!
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
        arrFood.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "LocationCellList", for: indexPath) as! LocationCellList
        cell.bindData(food: arrFood[indexPath.item])
        cell.contentView.layer.cornerRadius = 10
        return cell
    }
    
    
}
