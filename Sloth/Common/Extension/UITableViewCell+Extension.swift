//
//  UITableViewCell+Extension.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
      return String(describing: self)
    }
}
