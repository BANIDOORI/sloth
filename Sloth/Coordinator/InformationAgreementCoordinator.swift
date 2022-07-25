//
//  InformationAgreementCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/10.
//

import UIKit

class InformationAgreementCoordinator: Coordinator {
    var children: [Coordinator] = []
    var router: Router
    private let viewController: UIViewController
    
    init(router: Router,
         viewController: UIViewController) {
        self.router = router
        self.viewController = viewController
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        router.present(viewController: viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension InformationAgreementCoordinator: InformationAgreementNavigator {
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showLectureList() {
        // NOTE: NEED TO IMPLEMENT
    }
}
