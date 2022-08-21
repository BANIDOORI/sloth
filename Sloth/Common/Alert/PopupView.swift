//
//  PopupView.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/21.
//

import UIKit

class PopupView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
