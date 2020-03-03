//
//  ArrayResponse.swift
//  LetsEat
//
//  Created by thiet on 3/1/20.
//  Copyright © 2020 thiet. All rights reserved.
//

import Foundation


public struct ArrayResponse:Codable {
    public var data : Photo!
    public var message : String!
    public var result : Bool!
    
}
public struct Photo:Codable {
    public var destination : String!
    public var encoding : String!
    public var fieldname : String!
    public var filename : String!
    public var mimetype : String!
    public var originalname : String!
    public var path : String!
    public var size : Int!
}
