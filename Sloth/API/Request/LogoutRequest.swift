//
//  LogoutRequest.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import Foundation

class LogoutRequest: Requestable {
    var headers: [String : String]
    var body: [String : Any]?
    var httpMethod: HTTPMethod = .post
    var endpoint: Endpoint
    
    init(endpoint: Endpoint) {
        self.headers = ["Content-Type": "application/json; charset=utf-8"]
        self.endpoint = endpoint
    }
}
