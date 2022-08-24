//
//  MyAccountElement.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import Foundation
import UIKit

class MyAccountElement: MyPageElement {
    var type: MyPageElementType { .account }
    
    var iconImage: UIImage?
    var name: String
    var email: String
    
    init(name: String, email: String, iconImage: UIImage?) {
        self.name = name
        self.email = email
        self.iconImage = iconImage
    }
}
