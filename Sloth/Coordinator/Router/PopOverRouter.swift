//
//  PopOverRouter.swift
//  Sloth
//
//  Created by 심지원 on 2022/07/10.
//

import Foundation
import UIKit

class PopOverRouter: Router {
    
    private unowned let parentViewController: UIViewController
    
    private var onDismissedDictionary: [UIViewController : () -> ()] = [:]
    
    private var viewController: UIViewController?
    
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
    
    func present(viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        self.viewController = viewController
        parentViewController.present(viewController, animated: animated)
    }
    
    func dismiss(animated: Bool) {
        viewController?.dismiss(animated: animated)
        executeDismissedAction()
    }
    
    private func executeDismissedAction() {
        guard let viewController = viewController,
        let onDismissed = onDismissedDictionary[viewController] else {
            return
        }
        onDismissed()
        onDismissedDictionary[viewController] = nil
    }
}
