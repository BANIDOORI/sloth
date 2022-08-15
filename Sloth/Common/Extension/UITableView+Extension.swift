//
//  UITableView+Extension.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type) {
        self.register(type, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
