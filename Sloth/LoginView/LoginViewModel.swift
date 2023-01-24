//
//  LoginViewModel.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import Foundation
import Combine

class LoginViewModel {
    weak var navigator: LoginNavigator?
    
    private let service: LoginService
    private var disposable = Set<AnyCancellable>()
    
    init(service: LoginService) {
        self.service = service
    }
    
    func loginWithKakao() {
        service.loginWithKakao()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("LOGIN FAILED", error)
                case .finished:
                    print("LOGIN SUCCESS")
                }
            } receiveValue: { [weak navigator] _ in
                DispatchQueue.main.async{
                    navigator?.dismissAndStart()
                }
            }.store(in: &disposable)
    }
    
    func loginWithApple() {
        navigator?.dismissAndStart()
//        service.loginWithApple()
//            .sink { completion in
//                print(completion)
//            } receiveValue: { credential in
//                print(credential)
//            }
//            .store(in: &disposable)
    }
    
    func loginWithGoogle() {
        navigator?.dismissAndStart()
    }
}
