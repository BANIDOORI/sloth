//
//  LectureInformationRegisterCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/12.
//

import UIKit

class LectureInformationRegisterCoordinator: Coordinator {
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
    
    func present() {
        router.present(viewController: viewController, animated: true)
    }
}

extension LectureInformationRegisterCoordinator: LectureInformationRegisterNavigator {
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showLectureGoalRegister() {
        let coordinator = lectureGoalRegisterCoordinatorFactory()
        present(child: coordinator)
    }
}
