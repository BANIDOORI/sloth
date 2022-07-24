//
//  LectureInformationRegisterCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/12.
//

import UIKit

class LectureInformationRegisterCoordinator: Coordinator {
    var children: [Coordinator] = []
    var router: Router
    private let viewController: UIViewController
    
    private let lectureGoalRegisterCoordinatorFactory: () -> (Coordinator)
    
    init(router: Router,
         viewController: UIViewController,
         lectureGoalRegisterCoordinatorFactory: @escaping () -> (Coordinator)) {
        self.router = router
        self.viewController = viewController
        self.lectureGoalRegisterCoordinatorFactory = lectureGoalRegisterCoordinatorFactory
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        router.present(viewController: viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension LectureInformationRegisterCoordinator: LectureInformationRegisterNavigator {
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showLectureGoalRegister() {
        let coordinator = lectureGoalRegisterCoordinatorFactory()
        present(child: coordinator, animated: true)
    }
}
