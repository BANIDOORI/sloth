//
//  Endpoint.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import Foundation

struct Endpoint {
    let scheme: String
    let host: String
    var path: String
    var queryItems: [URLQueryItem] = []
    
    init(scheme: String, host: String, path: String, queryItems: [URLQueryItem] = []) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = queryItems
    }
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        if queryItems.count > 0 {
            components.queryItems = queryItems
        }
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}
