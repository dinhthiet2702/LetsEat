//
//  BaseResponseHistoryFoods.swift
//  LetsEat
//
//  Created by thiet on 3/5/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import Foundation

struct BaseResponseHistoryFoods:Codable {
    var data : [FoodsHistory]!
    var message : String!
    var result : Bool!
}
struct FoodsHistory:Codable {
    var amount : String!
    var dateorder : String!
    var id : String!
    var imgfood : String!
    var namefood : String!
    var price : String!
    var user_id : Int!
}
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
