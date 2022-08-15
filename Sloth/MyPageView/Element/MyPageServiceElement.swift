//
//  MyPageServiceElement.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import Foundation

enum MyPageServiceType: String {
    case enquiries = "문의사항"
    case logOut = "로그아웃"
    case signOut = "회원탈퇴"
}

class MyPageServiceElement: MyPageElement {
    var type: MyPageElementType { .service }
    
    var serviceType: [MyPageServiceType]
    
    init(serviceType: [MyPageServiceType]) {
        self.serviceType = serviceType
    }
}
