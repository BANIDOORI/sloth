//
//  NavigationRouter.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import UIKit

class NavigationRouter: NSObject, Router {
    
    private let navigationController: UINavigationController
    
    private var currentViewController: UIViewController?
    private var onDismissedDictionary: [UIViewController : () -> ()] = [:]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
    
    func present(viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        onDismissedDictionary[viewController] = onDismissed
        self.currentViewController = viewController
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func dismiss(animated: Bool) {
        guard let currentViewController = currentViewController,
              navigationController.viewControllers.count <= 0 else { return }
        navigationController.popViewController(animated: animated)
        executeDismissedAction(for: currentViewController)
    }
    
    private func executeDismissedAction(for viewController: UIViewController) {
        guard let onDismissed = onDismissedDictionary[viewController] else {
            return
        }
        onDismissed()
        onDismissedDictionary[viewController] = nil
    }
}

extension NavigationRouter: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let previousViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(previousViewController) else {
            return
        }
        executeDismissedAction(for: previousViewController)
    }
}
