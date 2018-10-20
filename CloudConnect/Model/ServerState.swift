//
//  ServerState.swift
//  CloudConnect
//
//  Created by Paul on 2018-10-20.
//  Copyright © 2018 Paul. All rights reserved.
//

import Foundation

class ServerState {
    
    var location: Int
    var name: String
    var ipAddress: String
    var ipSubnetMask: String
    var status: Dictionary<String, String>
    
    init(location: Int, name: String, ipAddress: String, ipSubnetMask: String, status: Dictionary<String, String>) {
        self.location = location
        self.name = name
        self.ipAddress = ipAddress
        self.ipSubnetMask = ipSubnetMask
        self.status = status
    }
    
}
