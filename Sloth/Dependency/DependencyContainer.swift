//
//  DependencyContainer.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import Foundation
import UIKit

class DependencyContainer {
    
    func makeMainCoordinator(window: UIWindow) -> Coordinator {
        let router = InitNavRouter(window: window)
        
        let viewController = MainViewController()
        
        let myPageCoordinatorFactory: () -> Coordinator = {
            self.makeMyPageCoordinator(navigationController: router.navigationController)
        }
        
        let coordinator = MainViewCoordinator(
            router: router,
            viewController: viewController,
            myPageCoordinatorFactory: myPageCoordinatorFactory
        )
        
        viewController.navigator = coordinator
        
        return coordinator
    }
    
    func makeMyPageCoordinator(navigationController: UINavigationController) -> Coordinator {
        let router = NavigationRouter(navigationController: navigationController)
        
        let viewController = MyPageViewController()
        
        let coordinator = MyPageCoordinator(
            router: router,
            viewController: viewController)
        return coordinator
    }
}

