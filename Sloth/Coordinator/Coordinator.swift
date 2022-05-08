//
//  Coordinator.swift
//  Sloth
//
//  Created by 심지원 on 2022/05/08.
//

import Foundation

protocol Coordinator: AnyObject {
  var router: Router { get }
  func present()
  func present(child: Coordinator)
  func dismiss()
}

extension Coordinator {
  func present(child: Coordinator) {
    child.present()
  }
  
  func dismiss() {
    router.dismiss()
  }
}
