//
//  LoginViewModel.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import Foundation
import Combine

class LoginViewModel {
    
    
    private let service: LoginService
    private var disposable = Set<AnyCancellable>()
    
    init(service: LoginService) {
        self.service = service
    }
    
    func loginWithKakao() {
        service.loginWithKakao() 
    }
    
    func loginWithApple() {
        service.loginWithApple()
            .sink { completion in
                print(completion)
            } receiveValue: { credential in
                print(credential)
            }
            .store(in: &disposable)

    }
}
