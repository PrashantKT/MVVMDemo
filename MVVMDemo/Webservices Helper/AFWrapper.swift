//
//  AFWrapper.swift
//  Empresario
//
//  Created by Prashant on 01/03/18.
//

import Foundation

import UIKit

class AFWrapper  {
    class func requestGETURL(_ strURL: String, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void) {
        
        
        guard let url = URL(string:strURL) else {  failure(NSError(domain: "Invalid URL", code: 1000, userInfo: nil)); return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, responase, error) in
            guard error == nil else {
                failure(error!)
                return
            }
            success(data!)
        }
        dataTask.resume()
        
    }
    

}
