//
//  AppleSessionManager.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import AuthenticationServices
import Combine
import Foundation

final class AppleSessionMananger: NSObject {
    
    private weak var window: UIWindow?
    private let signInResultPublisher: PassthroughSubject<ASAuthorizationAppleIDCredential, Error> = .init()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func signIn() -> AnyPublisher<ASAuthorizationAppleIDCredential, Error> {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
        return signInResultPublisher.eraseToAnyPublisher()
    }
}

extension AppleSessionMananger: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            signInResultPublisher.send(appleIDCredential)
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        signInResultPublisher.send(completion: .failure(error))
    }
}

extension AppleSessionMananger: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return window!
    }
}
