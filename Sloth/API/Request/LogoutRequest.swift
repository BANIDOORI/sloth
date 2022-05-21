//
//  LogoutRequest.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import Foundation

class LogoutRequest: Requestable {
    var httpMethod: HTTPMethod = .get
    var endpoint: Endpoint
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
}
