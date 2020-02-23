//
//  BaseResponseOrder.swift
//  LetsEat
//
//  Created by thiet on 2/22/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import Foundation
struct BaseResponseOrderFood:Codable{
    var data : [Foods]!
    var message : String!
    var result : Bool!
}
