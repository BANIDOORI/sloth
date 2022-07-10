//
//  InformationAgreementCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/10.
//

import UIKit

class InformationAgreementCoordinator: Coordinator {
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

extension InformationAgreementCoordinator: InformationAgreementNavigator {
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showLectureList() {
        // NOTE: NEED TO IMPLEMENT
    }
}
