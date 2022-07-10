//
//  NavigationRouter.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import UIKit

class NavigationRouter: Router {
  
  private let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func present(viewController: UIViewController, animated: Bool) {
    navigationController.pushViewController(viewController, animated: animated)
  }
  
  func dismiss() {
    if navigationController.viewControllers.count > 0 {
      navigationController.popViewController(animated: true)
    }
  }
}
