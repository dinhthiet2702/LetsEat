//
//  User.swift
//  LetsEat
//
//  Created by Ân Lê on 12/13/19.
//  Copyright © 2019 thiet. All rights reserved.
//

import Foundation
struct User: Codable {
    var birtday : String!
    var email : String!
    var firtname : String!
    var gender : String!
    var id : String!
    var lastname : String!
    var password : String!
    var phonenumber : String!
    var username : String!
    
}
struct Token: Codable {
    var data : [User]!
    var message : String!
    var result : Bool!
    var token : String!
    
}
struct Result:Codable {
    let result:Bool
    let message:String
}
