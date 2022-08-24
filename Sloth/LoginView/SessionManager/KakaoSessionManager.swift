//
//  KakaoSessionManager.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import Combine
import Foundation
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

enum KakaoSessionManagerError: Error {
    
    case kakaoError(_: Error)
    case unknownError
}

final class KakaoSessionManager {
    
    private let signInResultPublisher: PassthroughSubject<OAuthToken, KakaoSessionManagerError> = .init()
    
    func initSDK() {
        KakaoSDK.initSDK(appKey: "${NATIVE_APP_KEY}")
    }
    
    func isKakaoTalkSignInUrl(_ url: URL) -> Bool {
        return AuthApi.isKakaoTalkLoginUrl(url)
    }
    
    func handleOpenUrl(_ url: URL) -> Bool {
        return AuthController.handleOpenUrl(url: url)
    }
    
    func signInWithKakao() -> AnyPublisher<OAuthToken, KakaoSessionManagerError> {
        if UserApi.isKakaoTalkLoginAvailable() {
            signInnWithKakaoTalk()
        } else {
            signInWithKakaoAccount()
        }
        
        return signInResultPublisher.eraseToAnyPublisher()
    }
    
    private func signInnWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk { [weak self] token, error in
            self?.processSignInResult(with: (token, error))
        }
    }
    
    private func signInWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount {[weak self] token, error in
            self?.processSignInResult(with: (token, error))
        }
    }
    
    private func processSignInResult(with result: (token: OAuthToken?, error: Error?)) {
        if let error = result.error {
            signInResultPublisher.send(completion: .failure(.kakaoError(error)))
        } else if let token = result.token {
            signInResultPublisher.send(token)
        } else {
            signInResultPublisher.send(completion: .failure(.unknownError))
        }
    }
}
