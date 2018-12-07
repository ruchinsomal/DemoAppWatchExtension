//
//  NetworkConfiguration.swift
//  NickelFoxDemo
//
//  Created by Ruchin Somal on 07/12/18.
//  Copyright © 2018 Ruchin Somal. All rights reserved.
//

import Foundation
import Alamofire

func getRequest(_ url: String, params: [String: AnyObject]?, oauth: Bool, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    Alamofire.request(url, method: .get, parameters: params)
        .responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if response.result.error?._code == nil {
                
                let jsonResponse = JSON(data: response.data!)
                
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}

func postRequest(_ url: String, params: [String: AnyObject]?, oauth: Bool, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    Alamofire.request(url, method: .post, parameters: params)
        .responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if response.result.error?._code == nil {
                let jsonResponse = JSON(data: response.data!)
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}

func deleteRequest(_ url: String, params: [String: AnyObject]?, oauth: Bool, result: @escaping (JSON?, _ error: NSError?, _ statuscode: Int) -> ()) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    Alamofire.request(url, method: .delete, parameters: params)
        .responseData { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if response.result.error?._code == nil {
                let jsonResponse = JSON(data: response.data!)
                result(jsonResponse, nil, response.response!.statusCode)
            } else {
                result(nil, response.result.error as NSError?, response.result.error!._code)
            }
    }
}


