//
//  API.swift
//  CloudConnect
//
//  Created by Paul on 2018-10-20.
//  Copyright © 2018 Paul. All rights reserved.
//

import Foundation

class API {
    
    func fetchAllServerState(page: Int, completion: @escaping (Array<ServerState>?, String?)->Void){
        //https://45.55.43.15:9090/api/machine?page=0&size=10
        let baseUrl = "https://45.55.43.15:9090/api/machine?page=\(page)&size=10"
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        let url = URL(string: baseUrl)
        guard let link = url else {
            print("URL Found nil.")
            return
        }
        var request = URLRequest(url: link, cachePolicy:.useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = "GET"
        let dataTask = session.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print(httpResponse.statusCode)
                }
            }
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error.localizedDescription)
                    print(error.localizedDescription)
                }
                return
            }
            guard let data = data else {
                let dataError = "Data found nil"
                completion(nil, dataError)
                return
            }
            do {
                if let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any> {
                    var serverStateArray = Array<ServerState>()
                    if let contents = dict["content"] as? Array<Dictionary<String,Any>> {
                        for content in contents {
                            let location = content["id"] as! Int
                            let name = content["name"] as! String
                            let ipAddress = content["ipAddress"] as! String
                            let ipSubnetMask = content["ipSubnetMask"] as! String
                            let statusDict = content["status"] as! Dictionary<String, Any>
                            
                            let serverState = ServerState(location: location, name: name, ipAddress: ipAddress, ipSubnetMask: ipSubnetMask, status: statusDict as! Dictionary<String, String>)
                            
                            serverStateArray.append(serverState)
                        }
                        
                    }
                    
                    DispatchQueue.main.async {
                        completion(serverStateArray, nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error.localizedDescription)
                    print(error.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
    
}
