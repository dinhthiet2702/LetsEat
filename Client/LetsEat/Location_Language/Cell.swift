//
//  Cell.swift
//  LetsEat
//
//  Created by thiet on 12/15/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    @IBOutlet weak var textname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
