//
//  MenuFood.swift
//  LetsEat
//
//  Created by thiet on 2/6/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import Foundation

struct MenuFood {
    let id:String
    let name:String
    let imgFood:String
    let kindFood:[kindFood]
}
struct kindFood{
    let id:String
    let name:String
    var food:[Foods]
}
struct Foods {
    let id:String
    let nameFood:String
    let imgFood:String
    var price:Int
    var amount:Int
}

