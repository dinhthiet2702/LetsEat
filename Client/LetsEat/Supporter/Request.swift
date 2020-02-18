//
//  Request.swift
//  Buoi29
//
//  Created by Quân on 12/26/19.
//  Copyright © 2019 QuanNguyen. All rights reserved.
//

import Foundation
import Alamofire

typealias CompleteHandleJSON = (_ isSuccess: Bool, _ json: Any?, _ error: Error?)->()

struct RequestService {
    
    static let shared = RequestService()
    
    func request<T:Codable>(_ url:String, _ method:HTTPMethod, _ parameters:[String:String]?,_ encoder:ParameterEncoder , _ headers:HTTPHeaders?, _ objectType:T.Type, _ complete:@escaping CompleteHandleJSON){
        AF.request(url, method: method, parameters: parameters, encoder: encoder, headers: headers, interceptor: nil).response { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONDecoder.init().decode(objectType, from: data!)
                    complete(true,json,nil)
                } catch {
                    complete(false,data,nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                complete(false,nil,error)
            }
        }
        
    }
    
    func upload<T:Codable>(_ url:String, _ parameters:[String:String]?, _ objectType:T.Type, _ dataImages:[Dictionary<String,Any>]?, _ complete:@escaping CompleteHandleJSON){
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            // dua du lieu vao multipartFormData
            if let dataImages = dataImages {

                for dict in dataImages {

                    guard let data =  dict["value"] as? Data, let key: String = dict["key"] as? String else {return}

                    multipartFormData.append(data, withName: key, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")

                }

            }
            
        }, to: url).response { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONDecoder.init().decode(objectType, from: data!)
                    complete(true,json,nil)
                } catch {
                    complete(false,data,nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                complete(false,nil,error)
            }
        }
        
    }
    
}


