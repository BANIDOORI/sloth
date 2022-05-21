//
//  LoginService.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import Foundation
import Combine

struct LoginResult: Codable {
    let accessToken: String
    let accessTokenExpireTime: String
    let isNewMember: Bool
    let refreshToken: String
    let refreshTokenExpireTime: String
}

enum LoginProvider {
    case google(token: String, clientId: String)
    case kakao(token: String, clientId: String)
    case apple(toke: String, clientId: String, code: String)
}

class LoginService {
    
    @Published private(set) var loginResult: LoginResult?
    
    private var disposable = Set<AnyCancellable>()
    
    private let httpClient: HTTPClient
    private let requestMaker: RequestMaker
    
    init(httpClient: HTTPClient,
         requestMaker: RequestMaker) {
        self.httpClient = httpClient
        self.requestMaker = requestMaker
    }
    
    func login(with provider: LoginProvider) {
        let request = requestMaker.makeLoginRequest()
        httpClient
            .execute(request: request)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("ERROR", error.localizedDescription)
                case .finished:
                    print("FINISHED")
                }
            } receiveValue: { (result: LoginResult) in
                print(result)
            }
            .store(in: &disposable)

    }
}
