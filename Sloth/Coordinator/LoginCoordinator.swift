//
//  LoginCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/21.
//

import UIKit

class LoginCoordinator: Coordinator {
    typealias OnAction = () -> ()
    
    var router: Router
    private let viewController: UIViewController
    
    private let informationAgreementCoordinatorFactory: () -> (Coordinator)
    private let onSuccessAction: OnAction?
    
    init(router: Router,
         viewController: UIViewController,
         informationAgreementCoordinatorFactory: @escaping () -> (Coordinator),
         onSuccessAction: OnAction?) {
        self.router = router
        self.viewController = viewController
        self.informationAgreementCoordinatorFactory = informationAgreementCoordinatorFactory
        self.onSuccessAction = onSuccessAction
    }
    
    func present() {
        router.present(viewController: viewController, animated: true)
    }
}


extension LoginCoordinator: LoginNavigator {
    func showInformationAgreement() {
        let coordinator = informationAgreementCoordinatorFactory()
        present(child: coordinator)
    }
    
    func dismissAndStart() {
        dismiss(animated: true) {
            self.onSuccessAction?()
        }
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
