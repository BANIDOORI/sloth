//
//  LectureGoalRegisterCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/10.
//

import Foundation
import UIKit

class LectureGoalRegisterCoordinator: Coordinator {
    var children: [Coordinator] = []
    var router: Router
    private let viewController: UIViewController
    
    private let lectureRegisteSummaryCoordinatorFactory: () -> (Coordinator)
    
    init(router: Router,
         viewController: UIViewController,
         lectureRegisteSummaryCoordinatorFactory: @escaping () -> (Coordinator)
    ) {
        self.router = router
        self.viewController = viewController
        self.lectureRegisteSummaryCoordinatorFactory = lectureRegisteSummaryCoordinatorFactory
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        router.present(viewController: viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension LectureGoalRegisterCoordinator: LectureGoalRegisterNavigator {
    func showRegisterSummary() {
        let coordaintor = lectureRegisteSummaryCoordinatorFactory()
        present(child: coordaintor, animated: true)
    }
}
