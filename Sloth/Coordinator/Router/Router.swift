//
//  Router.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import UIKit

// 자기자신을 Present 하고 Dismiss 를 해주는 Router
protocol Router {
    func present(viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?)
    func dismiss(animated: Bool)
}
