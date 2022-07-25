//
//  LoginNavigator.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/10.
//

import Foundation

protocol LoginNavigator: AnyObject {
    func showInformationAgreement()
    func dismissAndStart()
    func dismiss() 
}
