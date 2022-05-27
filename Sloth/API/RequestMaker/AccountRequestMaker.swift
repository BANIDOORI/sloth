//
//  LoginRequestMaker.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import Foundation

protocol AccountRequestMaker {
    func makeLoginRequest(provider: SocialLoginProvider) -> URLRequest
    func makeLogoutRequest() -> URLRequest
}
