//
//  Requestable.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import Foundation

protocol Requestable {
    var headers: [String: String] { get set }
    var body: [String: Any]? { get set }
    var httpMethod: HTTPMethod { get set }
    var endpoint: Endpoint { get set }
    func makeURLRequest() -> URLRequest
}

extension Requestable {
    func makeURLRequest() -> URLRequest {
        let url = endpoint.url
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = httpMethod.rawValue
        
        if let body = self.body,
           let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) {
            request.httpBody = bodyData
        }
        
        return request
    }
}
