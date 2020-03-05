//
//  HistoryCell.swift
//  LetsEat
//
//  Created by thiet on 3/4/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    @IBOutlet weak var lbDateFood: UILabel!
    @IBOutlet weak var lbNameUser: UILabel!
    @IBOutlet weak var viewHistory: UIView!
    @IBOutlet weak var viewNonHistory: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
