//
//  UICollectionView+Extension.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ type: T.Type) {
      register(type, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
}
