//
//  EndpointProvider.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import Foundation

class EndpointProvider {
    private let urlProvider: URLProvider
    
    init(urlProvider: URLProvider) {
        self.urlProvider = urlProvider
    }
    
    func makeEndpoint(for type: EndpointType) -> Endpoint {
        let path: String
        let queryItems: [URLQueryItem] = []
        switch type {
        case .login:
            path = urlProvider.login
        case .logout:
            path = urlProvider.logout
        }
        
        return Endpoint(
            scheme: urlProvider.scheme,
            host: urlProvider.host,
            path: path,
            queryItems: queryItems
        )
    }
}
