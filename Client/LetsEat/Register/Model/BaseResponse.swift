//
//  Baseresponse.swift
//  LetsEat
//
//  Created by thiet on 2/18/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import Foundation

struct Register: Codable {
    var username:String
    var password:String
}
struct BaseResponse:Codable{
    let result:Bool
    let message:String
}
