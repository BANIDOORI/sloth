//
//  MyPageElement.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import Foundation

enum MyPageElementType {
    case account
    case service
    case pushNoti
}

protocol MyPageElement {
    var type: MyPageElementType { get }
}
