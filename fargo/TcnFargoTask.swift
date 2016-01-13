//
//  TcnFargoTask.swift
//  fargo
//
//  Created by Shuai Liu on 16/1/8.
//  Copyright © 2016年 vars.me. All rights reserved.
//

import Foundation

class TcnFargoTask: FargoTask {
    let api_key = "3050340951"
    
    override func apiURL() -> String {
        return "http://api.t.sina.com.cn/short_url/shorten.json"
    }
    
    override func httpMethod() -> FargoHTTPMethod {
        return .GET
    }
    
    override func getParams(url: String?) -> [String : String]? {
        if let param = url {
            return ["source": api_key, "url_long": param]
        }
        return nil
    }
    
    override func parseResult(data: NSData?) -> String? {
        if let result = data {
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(result, options: []) as? [[String: AnyObject]] {
                    
                    if let firstResult = json.first {
                        return firstResult["url_short"] as? String
                    } else {
                        return nil
                    }

                } else {
                    return nil
                }
            } catch {
                return nil
            }
        }
        return nil
    }
}