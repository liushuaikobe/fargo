//
//  GooglFargoTask.swift
//  fargo
//
//  Created by Shuai Liu on 16/1/8.
//  Copyright © 2016年 vars.me. All rights reserved.
//

import Foundation

public class GooglFargoTask: FargoTask {
    
    let api_key = "AIzaSyBSwbXhKQFzeD7PKH1XLfHLQkjRZNkjo-k"
    
    override func apiURL() -> String {
        return "https://www.googleapis.com/urlshortener/v1/url?key=\(api_key)"
    }
    
    override func httpMethod() -> FargoHTTPMethod {
        return .POST
    }
    
    override func postData(url: String?) -> NSData? {
        if let param = url {
            let body = ["longUrl": param]
            do {
                return try NSJSONSerialization.dataWithJSONObject(body, options: [])
            } catch {
                return nil
            }
        }
        return nil
    }
    
    override func parseResult(data: NSData?) -> String? {
        if let result = data {
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(result, options: []) as? [String: String] {
                    return json["id"]
                } else {
                    return nil
                }
            } catch {
                return nil
            }
        }
        return nil
    }
    
    override func headers() -> [String : String] {
        return ["Content-Type": "application/json"]
    }
}