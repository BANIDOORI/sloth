//
//  StartCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/10.
//

import UIKit

class StartCoordinator: Coordinator {
    typealias OnAction = () -> ()
    
    var children: [Coordinator] = []
    var router: Router
    private let viewController: UIViewController
    
    private let loginCoordinatorFactory: (OnAction?) -> (Coordinator)
    private let informationAgreementCoordinatorFactory: () -> (Coordinator)
    private let mainCoordinatorFactory: () -> (Coordinator)

    init(router: Router,
         viewController: UIViewController,
         loginCoordinatorFactory: @escaping (OnAction?) -> (Coordinator),
         informationAgreementCoordinatorFactory: @escaping () -> (Coordinator),
         mainCoordinatorFactory: @escaping () -> (Coordinator)
    ) {
        self.router = router
        self.viewController = viewController
        self.loginCoordinatorFactory = loginCoordinatorFactory
        self.informationAgreementCoordinatorFactory = informationAgreementCoordinatorFactory
        self.mainCoordinatorFactory = mainCoordinatorFactory
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        router.present(
            viewController: viewController,
            animated: animated,
            onDismissed: onDismissed
        )
    }
}

extension StartCoordinator: StartNavigator {
    func showLogin() {
        let coordinator = loginCoordinatorFactory {
            self.showInformationAgreement()
        }
        present(child: coordinator, animated: true)
    }
    
    private func showInformationAgreement() {
        let coordinator = informationAgreementCoordinatorFactory()
        present(child: coordinator, animated: true)
    }
    
    func showMain() {
        let coordinator = mainCoordinatorFactory()
        present(child: coordinator, animated: true)
    }
}

