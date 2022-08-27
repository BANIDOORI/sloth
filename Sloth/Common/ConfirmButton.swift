//
//  ConfirmButton.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/12.
//

import UIKit

class ConfirmButton: UIButton {
    var activeBackgroundColor: UIColor = .primary400 {
        didSet {
            backgroundColor = activeBackgroundColor
        }
    }
    var disableBackgroundColor: UIColor? = .gray300
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? activeBackgroundColor : disableBackgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAttributes() {
        titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        setTitleColor(.white, for: .normal)
        titleLabel?.textAlignment = .center
        
        layer.cornerRadius = 10
        backgroundColor = activeBackgroundColor
    }
}

