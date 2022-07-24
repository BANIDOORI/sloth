//
//  LectureListCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/23.
//

import Foundation
import UIKit

final class LectureListCoordinator: Coordinator {
    var children: [Coordinator] = []
    var router: Router
    private let viewController: UIViewController
    
    private let lectureRegisterCoordinatorFactory: () -> (Coordinator)
    
    init(router: Router,
         viewController: UIViewController,
         lectureRegisterCoordinatorFactory: @escaping () -> (Coordinator)
    ) {
        self.router = router
        self.viewController = viewController
        self.lectureRegisterCoordinatorFactory = lectureRegisterCoordinatorFactory
    }
    
    func present(animated: Bool, onDismiss: (() -> Void)?) {
        router.present(viewController: viewController, animated: true)
    }
}

extension LectureListCoordinator: LectureListNavigator {
    func showLectureRegister() {
        let coordinator = lectureRegisterCoordinatorFactory()
        present(child: coordinator, animated: true)
    }
}

