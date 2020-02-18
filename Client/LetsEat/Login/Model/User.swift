//
//  User.swift
//  LetsEat
//
//  Created by Ân Lê on 12/13/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import Foundation
struct User: Codable {
    let id:String
    let name:String
    let age:Int
    let gender:String
}
struct Token: Codable {
    let result:Bool
    let message:String
    let data: [User]
    let token:String
}
struct Result:Codable {
    let result:Bool
    let message:String
    let data: [User]
}
