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
    
    init(router: Router,
         viewController: UIViewController) {
        self.router = router
        self.viewController = viewController
    }
    
    func present(animated: Bool, onDismiss: (() -> Void)?) {
        router.present(viewController: viewController, animated: true)
    }
}
