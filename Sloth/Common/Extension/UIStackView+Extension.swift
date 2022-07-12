//
//  UIStackView+Extension.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/10.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
