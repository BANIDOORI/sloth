//
//  Requestable.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import Foundation

protocol Requestable {
    var httpMethod: HTTPMethod { get set }
    var endpoint: Endpoint { get set }
    func makeURLRequest() -> URLRequest
}

extension Requestable {
    func makeURLRequest() -> URLRequest {
        let url = endpoint.url
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        return request
    }
}
