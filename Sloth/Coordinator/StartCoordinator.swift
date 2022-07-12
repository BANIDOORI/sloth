//
//  StartCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/10.
//

import UIKit

class StartCoordinator: Coordinator {
    typealias OnAction = () -> ()
    
    var router: Router
    private let viewController: UIViewController
    
    private let loginCoordinatorFactory: (OnAction?) -> (Coordinator)
    private let informationAgreementCoordinatorFactory: () -> (Coordinator)
    private let lectureInformationRegisterCoordinatorFactory: () -> (Coordinator)
    
    init(router: Router,
         viewController: UIViewController,
         loginCoordinatorFactory: @escaping (OnAction?) -> (Coordinator),
         informationAgreementCoordinatorFactory: @escaping () -> (Coordinator),
         lectureInformationRegisterCoordinatorFactory: @escaping () -> (Coordinator)) {
        self.router = router
        self.viewController = viewController
        self.loginCoordinatorFactory = loginCoordinatorFactory
        self.informationAgreementCoordinatorFactory = informationAgreementCoordinatorFactory
        self.lectureInformationRegisterCoordinatorFactory = lectureInformationRegisterCoordinatorFactory
    }
    
    func present() {
        router.present(viewController: viewController, animated: true)
    }
}

extension StartCoordinator: StartNavigator {
    func showLogin() {
        let coordinator = loginCoordinatorFactory {
            self.showInformationAgreement()
        }
        present(child: coordinator)
    }
    
    private func showInformationAgreement() {
        let coordinator = informationAgreementCoordinatorFactory()
        present(child: coordinator)
    }
    
    func showRegisterLecture() {
        let coordinator = lectureInformationRegisterCoordinatorFactory()
        present(child: coordinator)
    }
}

