//
//  LectureDetailCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/09/05.
//

import UIKit

class LectureDetailCoordinator: Coordinator {
    var children: [Coordinator] = []
    var router: Router
    private let viewController: UIViewController
    private let lectureEditCoordinatorFactory: () -> Coordinator
    
    init(
        router: Router,
        viewController: UIViewController,
        lectureEditCoordinatorFactory: @escaping () -> Coordinator
    ) {
        self.router = router
        self.viewController = viewController
        self.lectureEditCoordinatorFactory = lectureEditCoordinatorFactory
    }
    
    func present(animated: Bool, onDismissed: (() -> Void)?) {
        router.present(viewController: viewController, animated: animated, onDismissed: onDismissed)
    }
}

extension LectureDetailCoordinator: LectureDetailNavigator {
    func showLectureEdit() {
        let coordinator = lectureEditCoordinatorFactory()
        present(child: coordinator, animated: true)
    }
}
