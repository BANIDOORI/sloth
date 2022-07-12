//
//  LoginService.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import Foundation
import Combine
import AuthenticationServices

enum LoginError: Error {
    case kakaoError(error: KakaoSessionManagerError)
    case serverError
    case decodeError
    case unknown
}

struct LoginResponse: Codable {
    let accessToken: String?
    let accessTokenExpireTime: String?
    let refreshToken: String?
    let refreshTokenExpireTime: String
}

enum LoginProvider {
    case google(token: String, clientId: String)
    case kakao(token: String, clientId: String)
    case apple(toke: String, clientId: String, code: String)
}

class LoginService {
    
    @Published private(set) var loginResult: LoginResponse?
    
    private var disposable = Set<AnyCancellable>()
    
    private let kakaoSessionManager: KakaoSessionManager
    private let appleSessionManager: AppleSessionMananger
    private let networkManager: NetworkManager
    private let requestMaker: RequestMaker
    
    init(kakaoSessionManager: KakaoSessionManager,
         appleSessionManager: AppleSessionMananger,
         networkManager: NetworkManager,
         requestMaker: RequestMaker
    ) {
        self.kakaoSessionManager = kakaoSessionManager
        self.appleSessionManager = appleSessionManager
        self.networkManager = networkManager
        self.requestMaker = requestMaker
    }
    
    func loginWithKakao() -> AnyPublisher<LoginResponse, LoginError> {
        return kakaoSessionManager.signInWithKakao()
            .mapError { error -> LoginError in
                return .kakaoError(error: error)
            }
            .flatMap { [weak self] token -> AnyPublisher<LoginResponse, LoginError> in
                guard let strongSelf = self else {
                    return Fail(error: LoginError.unknown).eraseToAnyPublisher()
                }
                return strongSelf.getClientToken(with: token.accessToken)
            }.eraseToAnyPublisher()
    }
    
    private func getClientToken(with token: String) -> AnyPublisher<LoginResponse, LoginError> {
        let request = requestMaker.makeLoginRequest(provider: .kakao(token: token))
        return networkManager.execute(request: request)
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .mapError { error -> LoginError in
                print("[LOGIN] ERROR \(error)")
                if error is DecodingError {
                    return .decodeError
                }
                return .unknown
            }.eraseToAnyPublisher()
    }
    
    func loginWithApple() -> AnyPublisher<ASAuthorizationAppleIDCredential, Error> {
        return appleSessionManager.signIn()
    }
    
//    func login(with provider: LoginProvider) {
//        let request = requestMaker.makeLoginRequest()
//        httpClient
//            .execute(request: request)
//            .sink { completion in
//                switch completion {
//                case .failure(let error):
//                    print("ERROR", error.localizedDescription)
//                case .finished:
//                    print("FINISHED")
//                }
//            } receiveValue: { (result: LoginResult) in
//                print(result)
//            }
//            .store(in: &disposable)
//
//    }
}
