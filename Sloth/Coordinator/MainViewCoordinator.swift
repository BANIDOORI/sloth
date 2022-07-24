//
//  MainViewCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import Foundation
import UIKit


class MainViewCoordinator: Coordinator {
    var children: [Coordinator] = []
    var router: Router
    
    private let viewController: UIViewController
    
    private let myPageCoordinatorFactory: () -> (Coordinator)
    
    init(router: Router,
         viewController: UIViewController,
         myPageCoordinatorFactory: @escaping () -> (Coordinator)) {
        self.router = router
        self.viewController = viewController
        self.myPageCoordinatorFactory = myPageCoordinatorFactory
    }
    
    func present(animated: Bool, onDismiss: (() -> Void)?) {
        router.present(viewController: viewController, animated: true)
    }
}

extension MainViewCoordinator: MainViewNavigator {
    func showMyPage() {
        let coordinator = myPageCoordinatorFactory()
        present(child: coordinator, animated: true)
    }
}
