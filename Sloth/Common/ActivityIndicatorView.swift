//
//  ActivityIndicatorView.swift
//  Sloth
//
//  Created by Eojin on 2022/05/15.
//

import UIKit

final class ActivityIndicatorView: UIActivityIndicatorView {
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)

        setUp()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        hidesWhenStopped = true
    }
}
