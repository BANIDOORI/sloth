//
//  LectureEditCoordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/08/15.
//

import UIKit

class LectureEditCoordinator: Coordinator {
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

extension LectureEditCoordinator: LectureEditNavigator {
    func close() {
        dismiss(animated: true, completion: nil)
    }
}
