//
//  loadImageServer.swift
//  LetsEat
//
//  Created by thiet on 3/4/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(nameImage: String) {
        let url:URL = URL(string: "http://localhost:3000/\(nameImage)")!
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
