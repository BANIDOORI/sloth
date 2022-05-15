//
//  TitleTextField.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/15.
//

import UIKit

class TitleTextField: TitleInput {
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textField.keyboardType = keyboardType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
