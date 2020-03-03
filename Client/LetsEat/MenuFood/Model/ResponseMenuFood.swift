//
//  BaseResponseMenuFood.swift
//  LetsEat
//
//  Created by thiet on 2/21/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import Foundation
import UIKit
struct BaseResponseFoodsAmount:Codable {
    var result : Bool!
}
struct BaseResponseOrder:Codable {
    var result:Bool!
    var message:String!
}
extension UIImageView {
    func load(url: URL) {
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
