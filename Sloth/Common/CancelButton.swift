//
//  CancelButton.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/12.
//

import UIKit

class CancelButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttributes() {
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel?.textColor = .gray600
        titleLabel?.textAlignment = .center
        
        layer.cornerRadius = 10
        backgroundColor = .gray200
    }
}
