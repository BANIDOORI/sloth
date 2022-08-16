//
//  PushNotiElement.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import Foundation

class PushNotiElement: MyPageElement {
    var type: MyPageElementType { .pushNoti }
    
    var isOn: Bool
    
    init(isOn: Bool) {
        self.isOn = isOn
    }
}
