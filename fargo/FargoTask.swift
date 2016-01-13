//
//  FargoTask.swift
//  fargo
//
//  Created by Shuai Liu on 16/1/8.
//  Copyright © 2016年 vars.me. All rights reserved.
//

import Foundation

enum FargoHTTPMethod {
    case POST
    case GET
}

class FargoTask: NSObject, NSURLConnectionDataDelegate {
    
    var url: String?
    
    var errorBlock: (NSError? -> Void)?
    var successBlock: ((String, String) -> Void)?
    
    func shorten(url: String) -> FargoTask {
        self.url = url
        return self
    }
    
    func success(s: (String, String) -> Void) -> FargoTask {
        successBlock = s
        return self
    }
    
    func error(e: NSError? -> Void) -> FargoTask {
        errorBlock = e
        return self
    }
    
    func fargo() {
        
        // if url is nil, shouldn't fargo
        guard self.url != nil else {
            callErrorBlock(nil)
            return
        }
        
        if let api = NSURL(string: apiURL()) {
            
            let request = NSMutableURLRequest(URL: api)
            
            // API is GET or POST
            switch httpMethod() {
                case .GET:
                    request.HTTPMethod = "GET"
                    request.URL = NSURL(string: apiURL() + buildQuery(getParams(url)))
                case .POST:
                    request.HTTPMethod = "POST"
                    if let data = postData(url) {
                        request.setValue("Content-Length", forHTTPHeaderField: String(data.length))
                        request.HTTPBody = data
                    }
            }
            
            // Custom Headers
            for (key, value) in headers() where !key.isEmpty {
                request.setValue(value, forHTTPHeaderField: key)
            }
            
            // Send Request
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                // Get Response
                data, response, error in
                
                // check error
                guard error == nil else {
                    self.callErrorBlock(error)
                    return
                }
                
                // status code should be 200 else call errorBlock
                if let r = response as? NSHTTPURLResponse {
                    if r.statusCode != 200 {
                        self.callErrorBlock(nil)
                        return
                    }
                }
            
                // only if we get the short url successfully
                if let result = self.parseResult(data) {
                    self.callSuccessBlock(self.url!, shortUrl: result)
                } else {
                    self.callErrorBlock(nil)
                }
                
            }
            task.resume()
        }
    }
    
    func callErrorBlock(error: NSError?) {
        if let _errorBlock = self.errorBlock {
            dispatch_async(dispatch_get_main_queue()) {
                _errorBlock(error)
            }
        }
    }
    
    func callSuccessBlock(originUrl: String, shortUrl: String) {
        if let _successBlock = self.successBlock {
            dispatch_async(dispatch_get_main_queue()) {
                _successBlock(originUrl, shortUrl)
            }
        }
    }
    
    func buildQuery(params: [String: String]?) -> String {
        
        if let items = params {
            let urlComp = NSURLComponents()
            
            urlComp.queryItems = items.filter {
                return !$0.0.isEmpty
            }.map {
                return NSURLQueryItem(name: $0.0, value: $0.1)
            }
            
            if let ret = urlComp.URL {
                return ret.absoluteString == "?" ? "" : ret.absoluteString
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
    
    // MARK: Should be overriden by SubClasses
    
    internal func headers() -> [String: String] {
        return ["": ""]
    }
    
    internal func apiURL() -> String {
        return ""
    }
    
    internal func postData(url: String?) -> NSData? {
        return nil
    }
    
    internal func getParams(url: String?) -> [String: String]? {
        return nil
    }
    
    internal func httpMethod() -> FargoHTTPMethod {
        return .GET
    }
    
    internal func parseResult(data: NSData?) -> String? {
        return nil
    }
    
    internal func onGetResponseError(error: NSError?) {
        
    }
}
