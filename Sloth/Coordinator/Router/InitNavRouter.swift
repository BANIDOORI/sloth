//
//  InitNavRouter.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import UIKit

class InitNavRouter: Router {
    
    var navigationController: UINavigationController!
    
    private let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    func present(viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func dismiss(animated: Bool) {}
}
