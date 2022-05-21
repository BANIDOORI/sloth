//
//  RequestMaker.swift
//  SlothTests
//
//  Created by 심지원 on 2022/05/21.
//

import Foundation

class RequestMaker {
    private let endpointProvider: EndpointProvider
    
    init(endpointProvider: EndpointProvider) {
        self.endpointProvider = endpointProvider
    }
}

extension RequestMaker: AccountRequestMaker {
    func makeLogoutRequest() -> URLRequest {
        let endpoint = endpointProvider.makeEndpoint(for: .logout)
        let request = LogoutRequest(endpoint: endpoint)
        return request.makeURLRequest()
    }
    
    func makeLoginRequest() -> URLRequest {
        let endpoint = endpointProvider.makeEndpoint(for: .login)
        let request = LoginReqeust(endpoint: endpoint)
        return request.makeURLRequest()
    }
}
