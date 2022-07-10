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
    private var viewController: UIViewController?
    
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
    
    func present(viewController: UIViewController, animated: Bool) {
        self.viewController = viewController
        parentViewController.present(viewController, animated: animated)
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
