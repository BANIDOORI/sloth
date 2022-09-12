//
//  MainViewCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import Foundation
import UIKit


class MainViewCoordinator: Coordinator {
    var children: [Coordinator] = []
    var router: Router
    
    private let viewController: UIViewController
    
    private let lectureRegisterCoordinatorFactory: () -> (Coordinator)
    private let lectureDetailCoordinatorFactory: () -> (Coordinator)
    
    init(
        router: Router,
        viewController: UIViewController,
        lectureRegisterCoordinatorFactory: @escaping () -> (Coordinator),
        lectureDetailCoordinatorFactory: @escaping () -> (Coordinator)
    ) {
        self.router = router
        self.viewController = viewController
        self.lectureRegisterCoordinatorFactory = lectureRegisterCoordinatorFactory
        self.lectureDetailCoordinatorFactory = lectureDetailCoordinatorFactory
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        router.present(viewController: viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension MainViewCoordinator: MainViewNavigator {
    func showLectureRegister() {
        let coordinator = lectureRegisterCoordinatorFactory()
        present(child: coordinator, animated: true)
    }
    
    func showLectureDetail() {
        let coordinator = lectureDetailCoordinatorFactory()
        present(child: coordinator, animated: true)
    }
}
