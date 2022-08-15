//
//  LectureRegisterSummaryCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

final class LectureRegisterSummaryCoordinator: Coordinator {
    var children: [Coordinator] = []
    
    var router: Router
    
    private let viewController: UIViewController
    
    init(router: Router,
         viewController: UIViewController) {
        self.router = router
        self.viewController = viewController
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        router.present(viewController: viewController, animated: true, onDismissed: onDismissed)
    }
}

extension LectureRegisterSummaryCoordinator: LectureRegisterSummaryNavigator {
    func close() {
        router.dismiss(to: 3)
    }
    
    func backToEdit() {
        router.dismiss(animated: true)
    }
}
