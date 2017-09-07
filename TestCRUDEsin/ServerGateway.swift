//
//  ServerGateway.swift
//  TestCRUDEsin
//
//  Created by Кирилл on 07.09.17.
//  Copyright © 2017 Kirill Esin brahopru@gmail.com. All rights reserved.
//

import Foundation

enum Result {
    case Error(NSError)
    case Result(NSDictionary)
}

class ServerGateway {

    private let session = URLSession.init(configuration: .default)

    func loadData (stringURL: String, httpMethod: String, completion: @escaping (Result) -> Void ) {
        
        guard let url = URL.init(string: stringURL) else {
            let error = NSError.init(domain: "ServerGateway", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey: "Unknown API response"])
            
            completion(.Error(error))
            print("url = nil", error)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        
        //task
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            //check for nil data
            guard let newData = data, error == nil else {
                let error = NSError.init(domain: "ServerGateway", code: 1, userInfo: [NSLocalizedFailureReasonErrorKey: "Unknown API response"])
                
                completion(.Error(error))
                return
            }
            
            //check for status code
            let resp = response as! HTTPURLResponse
            if resp.statusCode >= 200 && resp.statusCode < 300 {
                do {
                    let objects = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as! [String : Any]
                    completion(.Result(objects as NSDictionary))
                } catch {
                    let error = NSError.init(domain: "ServerGateway", code: 3, userInfo: [NSLocalizedFailureReasonErrorKey: "error while parsing"])
                    completion(.Error(error))
                    print(error)
                }
            } else {
                let error = NSError.init(domain: "ServerGateway", code: 4, userInfo: nil)
                completion(.Error(error))
                print("statusCode = \(resp.statusCode)")
            }
        }
        task.resume()
    }
    
}
