//
//  MenuFood.swift
//  LetsEat
//
//  Created by thiet on 2/6/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import Foundation

struct MenuFood:Codable {
    var id : String!
    var img : String!
    var name : String!
}
struct BaseResposeMenuFood:Codable {
    var data : [MenuFood]!
    var message : String!
    var result : Bool!
}
struct Foods:Codable {
    var amount : String!
    var id : String!
    var imgfood : String!
    var menufoodId : Int!
    var namefood : String!
    var namekindfood : String!
    var price : String!
}
struct BaseResposeFoods:Codable {
    var data : [Foods]!
    var message : String!
    var result : Bool!
}


