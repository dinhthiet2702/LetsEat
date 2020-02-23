//
//  BaseResponseMenuFood.swift
//  LetsEat
//
//  Created by thiet on 2/21/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import Foundation

struct BaseResponseFoodsAmount:Codable {
    var result : Bool!
}
struct BaseResponseOrder:Codable {
    var result:Bool!
    var message:String!
}
