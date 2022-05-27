//
//  LoginRequest.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import Foundation

enum SocialLoginProvider {
    case kakao(token: String)
}

class LoginReqeust: Requestable {
    var headers: [String : String]
    var body: [String : Any]?
    var httpMethod: HTTPMethod = .get
    var endpoint: Endpoint
    
    init(endpoint: Endpoint,
         provider: SocialLoginProvider) {
        headers = ["Content-Type": "application/json; charset=utf-8"]
        body = [:]
        
        switch provider {
        case .kakao(let token):
            headers["Authorization"] = token
            body?["socialType"] = "KAKAO"
        }
        
        self.endpoint = endpoint
        
    }
}
