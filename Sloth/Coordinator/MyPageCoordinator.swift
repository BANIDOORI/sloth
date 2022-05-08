//
//  MyPageCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import UIKit

class MyPageCoordinator: Coordinator {
    var router: Router
    
    private let viewController: UIViewController
    
    init(router: Router,
         viewController: UIViewController) {
        self.router = router
        self.viewController = viewController
    }
    
    func present() {
        router.present(viewController: viewController, animated: true)
    }
}
